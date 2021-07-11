require 'rails_helper'

# Checks that object is created AND that the proper object is returned
module Mutations
  module Contacts
    RSpec.describe CreateContact, type: :request do
      describe '.resolve' do
        before :each do
          User.destroy_all
          Contact.destroy_all
          @user = create(:user)
        end 
        it 'creates a contact' do
          expect(Contact.count).to eq(0)
          post '/graphql', params: { query: query(user_id: @user.id) }
          expect(Contact.count).to eq(1)
        end
        
        it 'returns a contact' do
          post '/graphql', params: { query: query(user_id: @user.id) }
          json = JSON.parse(response.body)
          data = json['data']['createContact']
          require 'pry'; binding.pry
          expect(data[contact][id]).to be(present)
          expect(data[contact][first_name]).to eq('Samara')
          expect(data[contact][last_name]).to eq('Rosenberg')
          expect(data[contact][phone_number]).to eq('+13038765432')
        end
      end

      def query(user_id:)
        <<~GQL
        mutation {
          contact: createContact(
          input: {
            firstName: "Samara"
            lastName: "Rosenberg"
            phoneNumber: "+13038765432"
            userId: #{user_id}
          }
          ) {
            id
            firstName
            lastName
            phoneNumber
            }
            errors
          }
        GQL
      end
    end
  end
end