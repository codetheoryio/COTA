class QuestionSourcesController < ApplicationController

  def create
    QuestionSource.new(file: params[:file])
  end
end