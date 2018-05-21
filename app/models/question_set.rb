class QuestionSet < ActiveRecord::Base
  acts_as_taggable

  # Validations
  validates :question_count, :tag_list, presence: true

  belongs_to :quiz
end
