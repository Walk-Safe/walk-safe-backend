class Trip < ApplicationRecord
  belongs_to :user
  validates :start_point, presence: true
  validates :end_point, presence: true
  validates :travel_mode, presence: true
  validates :eta, presence: false
  validates :eta_string, presence: false
end
