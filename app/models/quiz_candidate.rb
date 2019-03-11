class QuizCandidate < ActiveRecord::Base
  has_many :answers
  belongs_to :quiz
  belongs_to :candidate

  def prepare_quiz
    QuizCreatorJob.perform_later(self)
  end
end
