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
          def query
            <<~GQL
            mutation {
              createContact(
              input: {
                firstName: "Samara",
                lastName: "Rosenberg",
                phoneNumber: "+13038765432",
                userId: #{@user.id}
              }
              ) {
                  contact {
                  id
                  firstName
                  lastName
                  phoneNumber
                  }
                }
              }
            GQL
          end
          expect(Contact.count).to eq(0)
          post '/graphql', params: { query: query }
          expect(Contact.count).to eq(1)
        end

        it 'returns a contact' do
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
                  contact {
                  id
                  firstName
                  lastName
                  phoneNumber
                  }
                }
              }
            GQL
          end
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['createContact']
          expect(data['contact']['id']).to be_present
          expect(data['contact']['firstName']).to eq('Samara')
          expect(data['contact']['lastName']).to eq('Rosenberg')
          expect(data['contact']['phoneNumber']).to eq('+13038765432')
        end

        it 'returns an error with no phoneNumber input' do
          def query
            <<~GQL
            mutation {
              createContact(
              input: {
                firstName: "Samara"
                lastName: "Rosenberg"
                phoneNumber: ""
                userId: #{@user.id}
              }
              ) {
                  contact {
                  id
                  firstName
                  lastName
                  phoneNumber
                  }
                }
              }
            GQL
          end
          post '/graphql', params: { query: query }
          
          json = JSON.parse(response.body)
          expect(json).to be_a(Hash)
          expect(json['errors']).to be_an(Array)
          expect(json['errors'][0]['message']).to be_a(String)
          expect(json['errors'][0]['message']).to eq("Cannot return null for non-nullable field CreateContactPayload.contact")
        end

        it 'returns an error with no fristName input' do
          def query
            <<~GQL
            mutation {
              createContact(
              input: {
                firstName: ""
                lastName: "Rosenberg"
                phoneNumber: "+13038765432"
                userId: #{@user.id}
              }
              ) {
                  contact {
                  id
                  firstName
                  lastName
                  phoneNumber
                  }
                }
              }
            GQL
          end
          post '/graphql', params: { query: query }

          json = JSON.parse(response.body)
          expect(json).to be_a(Hash)
          expect(json['errors']).to be_an(Array)
          expect(json['errors'][0]['message']).to be_a(String)
          expect(json['errors'][0]['message']).to eq("Cannot return null for non-nullable field CreateContactPayload.contact")
        end

        it 'returns an error with no lastName input' do
          def query
            <<~GQL
            mutation {
              createContact(
              input: {
                firstName: "Sally"
                lastName: ""
                phoneNumber: "+13038765432"
                userId: #{@user.id}
              }
              ) {
                  contact {
                  id
                  firstName
                  lastName
                  phoneNumber
                  }
                }
              }
            GQL
          end
          post '/graphql', params: { query: query }

          json = JSON.parse(response.body)
          expect(json).to be_a(Hash)
          expect(json['errors']).to be_an(Array)
          expect(json['errors'][0]['message']).to be_a(String)
          expect(json['errors'][0]['message']).to eq("Cannot return null for non-nullable field CreateContactPayload.contact")
        end
      end
    end
  end
end
