require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do
          expect(User.count).to eq(0)
          post '/graphql', params: {query: query}
          expect(User.count).to eq(1)
        end

        it 'returns a user' do
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['createUser']
          expect(data['user']['firstName']).to eq('Luke')
          expect(data['user']['lastName']).to eq('Skywalker')
          expect(data['user']['username']).to eq('usetheforce')
        end
      end

      def query
       <<~GQL
       mutation {
         createUser(
         input: {
           firstName: "Luke"
           lastName: "Skywalker"
           username: "usetheforce"
         }
         ) {
           user {
             firstName
             lastName
             username
            }
           }
         }
       GQL
     end
    end
  end
end
