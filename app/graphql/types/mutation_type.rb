module Types
  class MutationType < Types::BaseObject
    field :create_contact, mutation: Mutations::CreateContact
    field :create_user, mutation: Mutations::CreateUser
    field :create_trip, mutation: Mutations::CreateTrip
  end
end
