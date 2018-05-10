class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def import
    Question.import(params[:file])
    redirect_to questions_url, notice: "Questions imported."
  end
end
