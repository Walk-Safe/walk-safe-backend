require 'rails_helper'

RSpec.describe "ETA Service" do
  describe "return ETA" do 
    it "returns ETA as an int"  do
      start_point = '1700 Wewatta Street Denver CO'
      end_point   = '2001 Blake St, Denver, CO 80205'
      travel_mode = 'walking'

      results = EtaService.get_eta(start_point, end_point, travel_mode)

      expect(results).to be_an(Integer)
      expect(results).to eq(794)
    end
  end
end