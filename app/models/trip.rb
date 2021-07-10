class Trip < ApplicationRecord
  belongs_to :user
  validates :start_point, presence: true
  validates :end_point, presence: true
  validates :travel_mode, presence: true
  validates :start_lat, presence: true
  validates :start_lon, presence: true
  validates :end_lat, presence: true
  validates :end_lon, presence: true
  validates :eta, presence: true

  enum status: [:walking, :bicycling, :driving]
  
end
