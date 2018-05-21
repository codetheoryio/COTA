class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def new
    @quiz = Quiz.new
    @quiz.question_sets.build
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @quiz.question_sets.build
  end

  def index
    @quizzes = Quiz.order("created_at DESC")
  end

  def show

  end

  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully Updated.' }
        format.json { render :show, status: :updated, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def quiz_params
    params.require(:quiz).permit(:name, :job_title, :time_limit, :introduction, :rules, :question_sets_attributes => [:id, :question_count, :tag_list, :_destroy])
  end
end
