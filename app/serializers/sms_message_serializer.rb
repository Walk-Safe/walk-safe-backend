class SmsMessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :mobile_number, :message
end
