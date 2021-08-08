require 'rails_helper'

RSpec.describe "Map Quest ETA Service" do
  describe "return ETA" do
    it "returns ETA as an int", :vcr  do
      start_point = '1700 Wewatta Street Denver CO'
      end_point   = '2001 Blake St, Denver, CO 80205'
      route_type  = 'pedestrian'

      results = MapQuestService.trip_duration_db(start_point, end_point, route_type)
      
      expect(results).to be_an(Hash)
      expect(results[:eta]).to eq(16)
      expect(results[:eta_string]).to eq("16 mins")
    end
  end
end
