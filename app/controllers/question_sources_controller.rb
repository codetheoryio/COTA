class QuestionSourcesController < ApplicationController

  def index
    @question_sources = QuestionSource.all
  end

  def create
    @question_source = QuestionSource.new(source_params)
    QuestionSource.transaction do
      @question_source.save!
      @question_source.process
    end
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