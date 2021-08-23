2:19
https://www.crimeometer.com/crime-data-api
CrimeoMeterCrimeoMeter
Crime Data API | CrimeoMeter
The Most Accurate Crime Data API In The World. Get instant worldwide crime data around the areas you care about. (2 MB)
https://www.crimeometer.com/crime-data-api


Mike Foy:slack_call:  2:22 PM
Refactor ideas :thread:

3 replies
Last reply today at 2:26 PMView thread

Mike Foy:slack_call:  3:17 PM
https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token

Mike Foy:slack_call:  3:23 PM
require 'twilio-ruby'

class SmsMessagesController < ApplicationController
  def create
    message_validation(sms_message_params)

    twilio_response = Twilio::REST::Client.new(ENV['account_sid'], ENV['auth_token']) 
    twilio_response.messages.create(
      from: ENV['twilio_number'],
      to:   params['mobile_number'],
      body: params['message']
    )
  end
  
  
  private

  def message_validation(sms_message_params)
    sms_message = MessageInfo.new(sms_message_params)
    if sms_message.mobile_number.nil? || sms_message.message.nil?
      render json: { errors: "Number and/or message blank" }, status: :bad_request
    else
      render json: SmsMessageSerializer.new(sms_message), status: :created
    end
  end
  
  def sms_message_params
    params.permit(:mobile_number, :message)
  end
end