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
          post '/graphql', params: { query: query }
          expect(Contact.count).to eq(1)
        end
        
        it 'returns a contact' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['contact']['id']).to be(present)
          expect(data['contact']['firstName']).to eq('Samara')
          expect(data['contact']['lastName']).to eq('Rosenberg')
          expect(data['contact']['phoneNumber']).to eq('+13038765432')
        end
      end

      def query
        <<~GQL
        mutation {
          createContact(
          input: {
            firstName: "Samara"
            lastName: "Rosenberg"
            phoneNumber: "+13038765432"
            userId: #{@user.id}
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