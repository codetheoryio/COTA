class Answer < ActiveRecord::Base
  belongs_to :candidate_question
  belongs_to :option

  validates :mark, numericality: { less_than_or_equal_to: 1, allow_nil: true }

  before_save :set_mark

  private

  def set_mark
    if self.option.present?
      self.mark = self.option.is_correct ? 1 : 0
    end
  end
end
