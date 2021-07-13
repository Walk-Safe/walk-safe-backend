require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query all users' do
      create(:user, first_name: "Test")
      create_list(:user, 4)
      result = WalkSafeBackendSchema.execute(query).as_json
      expect(result["data"]["allUsers"].count).to eq(5)
      expect(result["data"]["allUsers"].first["firstName"]).to eq("Test")

      users = User.all
      expect(result.dig("data", "allUsers")).to match_array(
      users.map { |user| {"firstName" => user.first_name, "lastName" => user.last_name, "username" => user.username} })
    end
  end

  def query
    <<~GQL
    {
      allUsers {
        firstName
        lastName
        username
        }
    }
    GQL
  end
end
