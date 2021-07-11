require 'rails_helper'

# Checks that object is created AND that the proper object is returned
module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do
          expect(User.count).to eq(0)
          post '/graphql', params: { query: query }
          expect(User.count).to eq(1)
        end
        
        it 'returns a user' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']
          expect(data['user']['id']).to be(present)
          expect(data['user']['firstName']).to eq('Fred')
          expect(data['user']['lastName']).to eq('Johnson')
          expect(data['user']['username']).to eq('tycho')
        end
      end

      def query
        <<~GQL
        mutation {
          createUser(
          input: {
            firstName: "Fred"
            lastName: "Johnson"
            username: "tycho"
          }
          ) {
            id
            firstName
            lastName
            username
            }
            errors
          }
        GQL
      end
    end
  end
end