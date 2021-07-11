FactoryBot.define do
  factory :trip do
    start_point { Faker::Address.full_address } 
    end_point { Faker::Address.full_address } 
    travel_mode { [0,1,2].sample } 
    start_lat { Faker::Address.latitude } 
    start_lon { Faker::Address.longitude } 
    end_lat { Faker::Address.latitude }
    end_lon { Faker::Address.longitude }
    eta { Faker::Number.number(digits: 5) }  
  end
end