class CandidatesController < ApplicationController
  # def invite
  #
  # 	respond_to do |format|
  #     format.html
  #     format.modal
  #   end
  # end
  def index
    @candidates = Candidate.order("created_at DESC")
  end

  def send_invite
    @candidate = Candidate.where(email: candidate_params[:email]).last
    @quiz = Quiz.where(id: candidate_params[:quiz_id]).last
    if @candidate.blank?
      @candidate = Candidate.new(candidate_params.except(:quiz_id))
    end

    begin
      respond_to do |format|
        if @candidate.save
          # Send candidate invitation
          CandidateNotifier.send_candidate_invitation(@candidate, @quiz).deliver_now
          @candidate.prepare_quiz(candidate_params[:quiz_id])
          format.html { redirect_to quizzes_url, notice: 'Candidate invitation was successfully Sent.' }
        else
          format.html { redirect_to quizzes_url, notice: 'Candidate invitation was not Sent.' }
        end
      end
    rescue Exception => e
      raise(e)
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
    params.require(:candidate).permit(:name, :email, :applied_position, :quiz_id)
  end
end
