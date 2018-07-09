class QuestionUploaderJob < ActiveJob::Base
  queue_as :default

  def perform(question_source)
    question_source.status = :processing
    question_source.process
    question_source.status = :processed
    question_source.save!
  end
end
