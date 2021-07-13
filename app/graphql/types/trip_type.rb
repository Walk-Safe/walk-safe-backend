module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :start_point, String, null: true
    field :end_point, String, null: true
    field :travel_mode, String, null: true
    field :eta, Integer, null: true
    field :eta_string, String, null: true
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
