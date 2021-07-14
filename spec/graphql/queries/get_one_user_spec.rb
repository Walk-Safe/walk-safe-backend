require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display one user' do
    it 'can query one user' do
      @user = create(:user)
      result = WalkSafeBackendSchema.execute(query).as_json
      expect(result["data"]["oneUser"]["firstName"]).to eq(@user.first_name)
      expect(result["data"]["oneUser"]["lastName"]).to eq(@user.last_name)
      expect(result["data"]["oneUser"]["username"]).to eq(@user.username)
    end
  end

  def query
    <<~GQL
    {
      oneUser(id: #{@user.id}) {
        firstName
        lastName
        username
        }
    }
    GQL
  end
end
