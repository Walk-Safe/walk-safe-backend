require 'rails_helper'
# Checks that object is created AND that the proper object is returned
module Mutations
  module Trips
    RSpec.describe CreateTrip, type: :request do
      describe '.resolve' do
        before :each do
          User.destroy_all
          Contact.destroy_all
          @user = create(:user)
        end
        it 'creates a trip', :vcr do
          # def query
          #   <<~GQL
          #   mutation {
          #     createTrip(
          #     input: {
          #       startPoint: "60/66 Kingsford Smith Street, Lyall Bay, Wellington 6022",
          #       endPoint: "119 Cuba Street, Te Aro, Wellington 6011",
          #       travelMode: "walking",
          #       userId: #{@user.id}
          #     }
          #     ) {
          #         trip {
          #         id
          #         startPoint
          #         endPoint
          #         travelMode
          #         eta
          #         etaString
          #         userId
          #         }
          #       }
          #     }
          #   GQL
          # end
          expect(Trip.count).to eq(0)
          post '/graphql', params: { query: query }
          expect(Trip.count).to eq(1)
        end
        it 'returns a trip', :vcr do
          # def query
          #   <<~GQL
          #   mutation {
          #     createTrip(
          #     input: {
          #       startPoint: "60/66 Kingsford Smith Street, Lyall Bay, Wellington 6022",
          #       endPoint: "119 Cuba Street, Te Aro, Wellington 6011",
          #       travelMode: "walking",
          #       userId: #{@user.id}
          #     }
          #     ) {
          #         trip {
          #         id
          #         startPoint
          #         endPoint
          #         travelMode
          #         eta
          #         etaString
          #         userId
          #         }
          #       }
          #     }
          #   GQL
          # end
          post '/graphql', params: { query: query }
          json = JSON.parse(response.body)
          data = json['data']['createTrip']
          expect(data['trip']['id']).to be_present
          expect(data['trip']['startPoint']).to eq("60/66 Kingsford Smith Street, Lyall Bay, Wellington 6022")
          expect(data['trip']['endPoint']).to eq("119 Cuba Street, Te Aro, Wellington 6011")
          expect(data['trip']['eta']).to eq(70)
          expect(data['trip']['etaString']).to eq('1 hour 10 mins')
          expect(data['trip']['userId']).to eq(@user.id)
        end

        it 'returns an error if a field is blank', :vcr do
          post '/graphql', params: { query: blank_field_query }
          json = JSON.parse(response.body)
          expect(json['errors'][0]['message']).to eq("Cannot return null for non-nullable field CreateTripPayload.trip")
        end

        it 'must have a user id' do
          post '/graphql', params: { query: no_user_query }
          json = JSON.parse(response.body)
          expect(json['errors'][0]['message']).to eq("Argument 'userId' on InputObject 'CreateTripInput' is required. Expected type Int!")
        end

        it 'shows error if addresses are invalid', :vcr do
          post '/graphql', params: { query: invalid_address_query }
          json = JSON.parse(response.body)
          expect(json['data']['createTrip']).to be_nil
          expect(json['errors'][0]['message']).to eq("Cannot return null for non-nullable field Trip.eta")
        end
      end
      def query
        <<~GQL
        mutation {
          createTrip(
          input: {
            startPoint: "60/66 Kingsford Smith Street, Lyall Bay, Wellington 6022",
            endPoint: "119 Cuba Street, Te Aro, Wellington 6011",
            travelMode: "walking",
            userId: #{@user.id}
          }
          ) {
              trip {
              id
              startPoint
              endPoint
              travelMode
              eta
              etaString
              userId
              }
            }
          }
        GQL
      end
      def blank_field_query
        <<~GQL
        mutation {
          createTrip(
          input: {
            startPoint: "",
            endPoint: "119 Cuba Street, Te Aro, Wellington 6011",
            travelMode: "walking",
            userId: #{@user.id}
          }
          ) {
              trip {
              id
              startPoint
              endPoint
              travelMode
              eta
              etaString
              userId
              }
            }
          }
        GQL
      end
      def no_user_query
        <<~GQL
        mutation {
          createTrip(
          input: {
            startPoint: "60/66 Kingsford Smith Street, Lyall Bay, Wellington 6022",
            endPoint: "119 Cuba Street, Te Aro, Wellington 6011",
            travelMode: "walking"
          }
          ) {
              trip {
              id
              startPoint
              endPoint
              travelMode
              eta
              etaString
              userId
              }
            }
          }
        GQL
      end
      def invalid_address_query
        <<~GQL
        mutation {
          createTrip(
          input: {
            startPoint: "Mars, Outer Space",
            endPoint: "Saturn, Outer Space",
            travelMode: "walking"
            userId: #{@user.id}
          }
          ) {
              trip {
              id
              startPoint
              endPoint
              travelMode
              eta
              etaString
              userId
              }
            }
          }
        GQL
      end
    end
  end
end
