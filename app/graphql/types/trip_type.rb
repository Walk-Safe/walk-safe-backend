module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :start_point, String, null: true
    field :end_point, String, null: true
    field :travel_mode, String, null: true
    field :start_lat, String, null: true
    field :start_lon, String, null: true
    field :end_lat, String, null: true
    field :end_lon, String, null: true
    field :eta, String, null: true
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
