class QuestionSourcesController < ApplicationController

  def index
    @question_sources = QuestionSource.all
  end

  def create
    @question_source = QuestionSource.new(source_params)
    @question_source.save!
    QuestionUploaderJob.perform_later(@question_source)
    flash[:success] = "Questions uploaded"
    redirect_to question_sources_path
  end

  def download_input_sheet
    send_file(
        Rails.root.join(self.question_sheet.path)
    )
  end

  private

  def source_params
    params.require(:question_source).permit(:question_sheet)
  end
end