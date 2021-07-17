class SmsMessage < ApplicationRecord
  validates :mobile_number, presence: true
  validates :message, presence: true
end
