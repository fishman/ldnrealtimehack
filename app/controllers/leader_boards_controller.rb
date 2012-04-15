class LeaderBoardsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @wins = Win.order('count desc').all
  end

  def create
    win = Win.find_or_create_by_user_id(current_user.id)
    win.count = win.count+1
    win.save
    render :js => "window.location.href = '/queues'"
  end
end
