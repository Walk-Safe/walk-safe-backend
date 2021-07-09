class User < ApplicationRecord
  has_many :contacts
  has_many :trips
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
end
