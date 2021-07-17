class User < ApplicationRecord
  has_many :contacts
  has_many :trips
  has_many :sms_messages
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
end
