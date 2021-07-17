class SmsMessageSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :mobile_number, :message
end
