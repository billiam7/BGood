class ChallengesController < ApplicationController
  def index
    @challenge = Challenge.new
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:name, :body)
  end

end
