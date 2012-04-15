class TwiliosController < ApplicationController
  def call
    Twilio::Call.make('442071838750', '44yournumber', 'http://iamtherealtimepusher.cloudfoundry.com')

    head :ok
  end
end
