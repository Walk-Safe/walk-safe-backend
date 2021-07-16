class Mutations::CreateContact < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :phone_number, String, required: true
  argument :user_id, Integer, required: true

  field :contact, Types::ContactType, null: false
  field :errors, [String], null: false

  def resolve(first_name:, last_name:, phone_number:, user_id:)
    contact = User.find(user_id).contacts.new(first_name: first_name, last_name: last_name, phone_number: phone_number)
    
    if contact.save
      {
        contact: contact,
        errors: []
      }
    else
      {
        contact: nil,
        errors: contact.errors.full_messages
      }
    end
  end
end
