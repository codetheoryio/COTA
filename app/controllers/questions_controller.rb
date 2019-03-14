class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = Question.preload(:tags, :options).all
  end

  def import
    Question.import(params[:file])
    redirect_to questions_url, notice: "Questions imported."
  end
end
