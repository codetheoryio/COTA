class QuestionSourcesController < ApplicationController
  load_and_authorize_resource

  def index
    @question_sources = QuestionSource.all
  end

  def create
    @question_source = QuestionSource.new(question_source_params)
    @question_source.save!
    QuestionUploaderJob.perform_later(@question_source)
    flash[:success] = "Questions uploaded"
    redirect_to question_sources_path
  end

  def download_input_sheet
    send_file(
        Rails.root.join(@question_source.question_sheet.path)
    )
  end

  def download_result_sheet
    send_file(
        Rails.root.join(@question_source.result_sheet.path)
    )
  end

  private

  def question_source_params
    params.require(:question_source).permit(:question_sheet)
  end
end