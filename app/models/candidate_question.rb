class CandidateQuestion < ActiveRecord::Base
  belongs_to :quiz_candidate
  belongs_to :question
  belongs_to :option
  has_one :answer
  accepts_nested_attributes_for :answer, :reject_if => lambda { |answer| ((answer[:answer_body].blank? && answer[:option_id].blank? ) && (answer[:remarks].blank? && answer[:mark].blank? )) }

  scope :not_answered, -> {where(answered: [false, nil])}
  scope :answered, -> {where(answered: true)}
  scope :subjective, -> {includes(:answer).where(answers: {option_id: nil})}
end
