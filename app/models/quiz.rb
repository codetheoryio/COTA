class Quiz < ActiveRecord::Base
  has_many :quiz_candidates
  has_many :question_sets
  has_many :answers, through: :quiz_candidate
end
