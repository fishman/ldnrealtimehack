class LeaderBoardsController < ApplicationController
  before_filter :authenticate_user!, :only => :create
  respond_to :json

  def index
    @wins = Win.order('count desc').limit(3).all

    respond_with @wins
  end

  def create
    win = Win.find_or_create_by_user_id(current_user.id)
    win.count = win.count+1
    win.save
    render :js => "window.location.href = '/queues'"
  end
end
