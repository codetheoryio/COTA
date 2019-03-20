class QuizCandidatesController < ApplicationController
  load_resource :quiz
  load_and_authorize_resource :through => :quiz

  before_action :set_candidate_question, only: [:submit_answer]
  before_action :can_take_assessment, :only => [:assessment, :submit_answer]

  def index
    @render_breadcrumb = breadcrumb_path({"Quizzes" => polymorphic_path(Quiz), "Quiz" => polymorphic_path([@quiz]), :disable => "Candidates"}, false)
    @quiz_candidates = @quiz.quiz_candidates.includes(:candidate)
  end

  def show
  end

  def create
    check_can_invite_candidate
    user = User.where(email: user_params[:email]).last
    generated_password = ''

    QuizCandidate.transaction do
      if user.blank?
        generated_password = Devise.friendly_token
        user = create_new_candidate_user(generated_password)
      end

      candidate = create_or_update_candidate(user, candidate_params)

      quiz_candidate = @quiz.quiz_candidates.new()
      quiz_candidate.candidate = candidate
      quiz_candidate.save!
      quiz_candidate.prepare_quiz

      # Invite Mail to Candidate
      CandidateNotifier.send_candidate_invitation(candidate, generated_password, quiz_candidate).deliver_now
    end

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Candidate invitation was successfully Sent.' }
    end

  rescue Exception => e
    # respond_to do |format|
    #   format.html { redirect_to quizzes_url, notice: 'Candidate invitation was not Sent.' }
    # end
    raise(e)
  end

  def assessment
    @quiz_done = @quiz_candidate.completed?
    @candidate_questions =  @quiz_candidate.candidate_questions.page(params[:page])
    @last_page = @candidate_questions.last_page?
    @candidate_questions.first.build_answer if @candidate_questions.first.present? && @candidate_questions.first.answer.blank?

    if @quiz_candidate.candidate_questions.present?
      QuizCandidate.transaction do
        @quiz_candidate.set_started!
        @quiz_candidate.set_assessment_times if @quiz_candidate.assessment_started_at.blank? || @quiz_candidate.assessment_ends_at.blank?
      end
    end
  end

  def submit_answer
    end_quiz = params[:end_quiz] == 'End Quiz' ? true : false
    @candidate_question.assign_attributes(answered: true) if answer_available? #candidate_question_params[:answer_attributes].blank?
    @candidate_question.assign_attributes(candidate_question_params)
    @candidate_question.save!
    @quiz_done = @quiz_candidate.candidate_questions.not_answered.blank?
    next_page =  @quiz_candidate.candidate_questions.page(params[:page]).next_page
    respond_to do |format|
      if @quiz_done || end_quiz
        @quiz_candidate.set_completed!
        format.html { redirect_to candidate_url(@quiz_candidate.candidate), notice: "Thank you for taking the quiz." }
      else
        alert_msg = 'There are some questions not answered, Please take a look!' if params[:page].present? && next_page.blank?
        format.html { redirect_to assessment_quiz_quiz_candidate_url(page: next_page, secure: params[:secure]), alert: alert_msg || nil }
      end
    end
  end

  private

  def set_candidate_question
    @candidate_question = CandidateQuestion.find(candidate_question_params[:id])
  end

  def can_take_assessment
    if @quiz_candidate.secure_assessment_url.present?
      # unless @quiz_candidate.right_candidate?(current_user)
      #   raise CanCan::AccessDenied.new("You are not a Right user to access this Assessment!")
      # end
      if @quiz_candidate.completed?
        raise CanCan::AccessDenied.new("System says you already completed the Quiz!")
      end
      if @quiz_candidate.secure_token_expire_at < Time.zone.now
        @quiz_candidate.set_timeout! unless @quiz_candidate.timeout?
        raise CanCan::AccessDenied.new("Your time for taking Quiz is over!")
      end
      if @quiz_candidate.assessment_ends_at.present? && @quiz_candidate.assessment_ends_at < Time.zone.now
        @quiz_candidate.set_timeout! unless @quiz_candidate.timeout?
        raise CanCan::AccessDenied.new("Your time for taking Quiz is over!")
      end
      unless params[:secure].present? && params[:secure] == @quiz_candidate.secure_assessment_token
        raise CanCan::AccessDenied.new("You must be invited and have a valid URL to submit assessment!")
      end
    end
  end

  def check_can_invite_candidate
    QuizCandidate.check_can_create_quiz_candidate(@quiz, user_params[:email])
  end

  def create_new_candidate_user(generated_password)
    User.create_new_candidate_user(user_params.merge(password: generated_password, password_confirmation: generated_password))
  end

  def create_or_update_candidate(user, candidate_params)
    if user&.candidate.blank?
      candidate = user.build_candidate(candidate_params)
      candidate.save!
    else
      candidate = user.candidate
      candidate.update_attributes(candidate_params)
    end
    candidate
  end

  def answer_available?
    answer_attr = candidate_question_params[:answer_attributes]
    answer_attr.present? && (answer_attr[:option_id].present? || answer_attr[:answer_body].present?)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def candidate_params
    params.require(:candidate).permit(:phone, :experience, :applied_position)
  end

  def candidate_question_params
    params.require(:candidate_question).permit(:id, answer_attributes: [:id, :option_id, :answer_body])
  end
end