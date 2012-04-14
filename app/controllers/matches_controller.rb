class MatchesController < ApplicationController
  before_filter :authenticate_user!, :check_matches

  def show
    if @match.player1_id == current_user.id
      @player_id = 1
    else
      @player_id = 2
    end
  end

  private
  def check_matches
    @match = Match.find_by_unique_id params[:id]
    redirect_to queues_path unless @match && (@match.player1_id == current_user.id || @match.player2_id == current_user.id)
  end
end
