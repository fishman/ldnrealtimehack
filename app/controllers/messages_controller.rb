class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:message].present?
      message = Message.new(:name => current_user.login, :content => params[:message])
      if message.save
        Pusher['ldnrealtime'].trigger('message_received', {:message => "@#{current_user.login}: #{params[:message]}"})
      end
    end

  end
end
