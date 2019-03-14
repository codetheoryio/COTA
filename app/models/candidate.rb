class Candidate < ActiveRecord::Base
  # Validations
  validates :user_id, presence: true

  has_many :quiz_candidates
  has_many :quizzes, through: :quiz_candidate
  belongs_to :user

  def name
    self.user.name
  end

  def email
    self.user.email
  end
end
