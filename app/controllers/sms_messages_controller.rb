require 'twilio-ruby'

class SmsMessagesController < ApplicationController
  def create
    sms_message = MessageInfo.new(sms_message_params)
    if sms_message.mobile_number.nil? || sms_message.message.nil?
      render json: { errors: "Number and/or message blank" }, status: :bad_request
    else
      render json: SmsMessageSerializer.new(sms_message), status: :created
    end 

    twilio_response = Twilio::REST::Client.new(ENV['account_sid'], ENV['auth_token']) 
    twilio_response.messages.create(
      from: ENV['twilio_number'],
      to:   params['mobile_number'],
      body: params['message']
    )
    # render json: twilio_response
  end

  private

  def sms_message_params
      params.permit(:mobile_number, :message)
  end
end
