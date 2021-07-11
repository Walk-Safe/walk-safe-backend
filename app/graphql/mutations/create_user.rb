class Mutations::CreateUser < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :username, String, required: true

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(first_name:, last_name:, username:)
    user = User.new(first_name: first_name, last_name: last_name, username: username)

    if user.save
      {
        user: user,
        errors: []
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
