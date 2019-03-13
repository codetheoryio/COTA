class QuizCandidatesController < ApplicationController

  before_action :set_quiz_candidate, only: [:show, :assessment, :submit_answer]
  before_action :set_quiz, only: [:index, :create, :assessment, :submit_answer]
  before_action :set_candidate_question, only: [:submit_answer]
  before_action :can_take_assessment, :only => [:assessment, :submit_answer]

  def index
    @quiz_candidates = @quiz.quiz_candidates.preload(:candidate)
  end

  def show
  end

  def create
    candidate = Candidate.where(email: candidate_params[:email]).last

    QuizCandidate.transaction do
      if candidate.blank?
        candidate = Candidate.create(candidate_params)
      end
      qc = @quiz.quiz_candidates.new()
      qc.candidate = candidate
      qc.save!
      qc.prepare_quiz
    end

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Candidate invitation was successfully Sent.' }
    end

  rescue Exception => e
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Candidate invitation was not Sent.' }
    end
    raise(e)
  end

  def assessment
    @quiz_done = @quiz_candidate.completed?
    @candidate_questions =  @quiz_candidate.candidate_questions.page(params[:page])
    @last_page = @candidate_questions.last_page?
    @candidate_questions.first.build_answer if @candidate_questions.first.present? && @candidate_questions.first.answer.blank?

    QuizCandidate.transaction do
      @quiz_candidate.set_started!
      @quiz_candidate.set_assessment_times if @quiz_candidate.assessment_started_at.blank? || @quiz_candidate.assessment_ends_at.blank?
    end
  end

  def submit_answer
    @candidate_question.assign_attributes(answered: true)
    @candidate_question.assign_attributes(candidate_question_params)
    @candidate_question.save!
    @quiz_done = @quiz_candidate.candidate_questions.not_answered.blank?
    next_page = params[:page].blank? ? 2 : params[:page].to_i + 1
    respond_to do |format|
      if @quiz_done
        @quiz_candidate.set_completed!
        format.html { redirect_to quizzes_url, notice: "Thank you for taking the quiz." }
      else
        format.html { redirect_to assessment_quiz_quiz_candidate_url(page: next_page, secure: params[:secure]) }
      end
    end
  end

  private

  def set_quiz_candidate
    @quiz_candidate = QuizCandidate.preload(:quiz, :candidate, :candidate_questions).find params[:id]
  end

  def set_quiz
    @quiz = Quiz.preload(:quiz_candidates).find params[:quiz_id]
  end

  def set_candidate_question
    @candidate_question = CandidateQuestion.find(candidate_question_params[:id])
  end

  def can_take_assessment
    if @quiz_candidate.secure_assessment_url.present?
      if @quiz_candidate.completed?
        redirect_to quizzes_url, alert: "System says you already completed the Quiz!"
      end
      if @quiz_candidate.secure_token_expire_at < Time.zone.now
        @quiz_candidate.set_timeout!
        redirect_to quizzes_url, alert: "Your time for taking Quiz is over!"
      end
      if @quiz_candidate.assessment_ends_at.present? && @quiz_candidate.assessment_ends_at < Time.zone.now
        @quiz_candidate.set_timeout! unless @quiz_candidate.timeout?
        redirect_to quizzes_url, alert: "Your time for taking Quiz is over!"
      end
      unless params[:secure].present? && params[:secure] == @quiz_candidate.secure_assessment_token
        redirect_to quizzes_url, alert: "You must be invited and have a valid URL to submit assessment"
      end
    end
  end

  def candidate_params
    params.require(:candidate).permit(:name, :email, :applied_position)
  end

  def candidate_question_params
    params.require(:candidate_question).permit(:id, answer_attributes: [:option_id, :answer_body])
  end
end