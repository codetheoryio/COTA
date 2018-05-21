class Quiz < ActiveRecord::Base
  # Validations
  validates :name, :job_title, :time_limit, presence: true

  has_many :quiz_candidates
  has_many :question_sets, inverse_of: :quiz
  has_many :answers, through: :quiz_candidate

  accepts_nested_attributes_for :question_sets, reject_if: :all_blank, allow_destroy: true
end
