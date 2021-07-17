class SmsMessage < ApplicationRecord
  validates :mobile_number, presence: true
  validates :message, presence: true
  
  belongs_to :user
end
