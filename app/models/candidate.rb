class Candidate < ActiveRecord::Base
  has_many :quiz_candidates
  has_many :quizzes, through: :quiz_candidate
end
