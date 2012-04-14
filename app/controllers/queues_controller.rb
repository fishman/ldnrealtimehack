class QueuesController < ApplicationController
  before_filter :authenticate_user!

  def index
    # see if someone is already in the queue waiting for 
    # us to be connected
    msg = ApplicationController.messages_queue.pop
    # Show the user what we got
    if msg[:payload].present? && msg[:payload] != :queue_empty
      match = Match.create(:player1_id => msg[:payload].to_i, :player2_id => current_user.id)
      redirect_to match_path(:id => match.unique_id)
    else
      # Send the message from the form's input box to the "messages"
      # queue, via the nameless exchange.  The name of the queue to
      # publish to is specified in the routing key.
      ApplicationController.nameless_exchange.publish current_user.id,
        :key => "messages"
      # Notify the user that we published.
      render :text => "everything is ok dude"
    end

  end

end
