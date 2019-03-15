class Answer < ActiveRecord::Base
  belongs_to :candidate_question
  belongs_to :option
end
