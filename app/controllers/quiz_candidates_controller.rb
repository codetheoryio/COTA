class QuizCandidatesController < ApplicationController

  before_action :set_quiz_candidate, only: [:show]
  before_action :set_quiz, only: [:index, :create]

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
      qc = @quiz.quiz_candidates.new(status: :invited)
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

  private

  def set_quiz_candidate
    @quiz_candidate = QuizCandidate.preload(:quiz, :candidate, :answers).find params[:id]
  end

  def set_quiz
    @quiz = Quiz.preload(:quiz_candidates).find params[:quiz_id]
  end

  def candidate_params
    params.require(:candidate).permit(:name, :email, :applied_position)
  end
end