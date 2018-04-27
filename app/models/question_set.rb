class QuestionSet < ActiveRecord::Base
  belongs_to :quiz
  has_many :tags, through: :tagging
  has_many :taggings, as: :taggable
end
