class Answer < ActiveRecord::Base
  belongs_to :quiz_candidate
  belongs_to :question
  belongs_to :option
end
