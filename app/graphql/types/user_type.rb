module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :username, String, null: true
    field :contacts, [Types::ContactType], null: true
    field :trips, [Types::TripType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # def one_user_information
    # end
    # def all_users_information
    # end
  end
end
