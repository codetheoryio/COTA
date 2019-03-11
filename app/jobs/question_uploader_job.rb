class QuestionUploaderJob < ActiveJob::Base
  queue_as :default

  def perform(question_source)
    question_source.set_processing!
    question_source.process
    question_source.set_processed!
    # question_source.save!
  end
end
