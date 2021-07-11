module Types
  class QueryType < Types::BaseObject
    # /users
    field :all_users, [Types::UserType], null: false

    def all_users
      User.all
    end

    field :one_user, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def one_user(id:)
      User.find(id)
    end
  end
end
