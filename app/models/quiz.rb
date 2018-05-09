class Quiz < ActiveRecord::Base
  has_many :quiz_candidates
  has_many :question_sets
  has_many :answers, through: :quiz_candidate

  # Validations
  validates :name, :job_title, :time_limit, presence: true
end
