class Candidate < ActiveRecord::Base
  # Validations
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: Devise.email_regexp

  has_many :quiz_candidates
  has_many :quizzes, through: :quiz_candidate
end
