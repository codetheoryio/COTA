class CandidateQuestion < ActiveRecord::Base
  belongs_to :quiz_candidate
  belongs_to :question
  belongs_to :option
  has_one :answer
  accepts_nested_attributes_for :answer

  scope :not_answered, -> {where(answered: [false, nil])}
  scope :answered, -> {where(answered: true)}
end
