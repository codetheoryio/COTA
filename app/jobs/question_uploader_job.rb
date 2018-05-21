class QuestionUploaderJob < ActiveJob::Base
  queue_as :default

  def perform(question_source)
    question_source.process
  end
end
