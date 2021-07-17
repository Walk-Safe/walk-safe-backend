class SmsMessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :mobile_number, :message
end
