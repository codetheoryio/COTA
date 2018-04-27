class QuizCandidate < ActiveRecord::Base
  has_many :answers
  belongs_to :quiz
  belongs_to :candidate
end
