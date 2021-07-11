class Trip < ApplicationRecord
  belongs_to :user
  validates :start_point, presence: true
  validates :end_point, presence: true
  validates :travel_mode, presence: true
  validates :start_lat, presence: false
  validates :start_lon, presence: false
  validates :end_lat, presence: false
  validates :end_lon, presence: false
  validates :eta, presence: false

  enum status: [:walking, :bicycling, :driving]
  
end
