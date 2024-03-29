class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    if params[:message].present?
      message = Message.new(:owner => current_user.login, :content => params[:message])
      if message.save
        Pusher['ldnrealtime'].trigger('message_received', {:message => "<a href='http://twitter.com/#{current_user.login}'>@#{current_user.login}</a>: #{CGI.escapeHTML(params[:message])}"})
      end
    end

  end
end
