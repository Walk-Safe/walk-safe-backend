require 'twilio-ruby'
# require 'application.yml'

class SmsMessagesController < ApplicationController
  def create
    # sms_message = Sms_Message.new(sms_message_params)
    
    twilio_response = Twilio::REST::Client.new(ENV['account_sid'], ENV['auth_token']) 
    # require 'pry'; binding.pry
    twilio_response.messages.create(
      from: ENV['twilio_number'],
      to:   params['mobile_number'],
      body: params['message']
    )

    render json: twilio_response
  end

  private

  def sms_message_params
      params.require(:sms_message).permit(:mobile_number, :message)
  end
end
