FactoryBot.define do
  factory :trip do
    start_point { Faker::Address.full_address } 
    end_point { Faker::Address.full_address } 
    travel_mode { ["walking","bicycling","driving"].sample } 
    eta { Faker::Number.number(digits: 5) }
    eta_string { "#{Faker::Number.number(digits: 1)} hours and #{Faker::Number.number(digits: 2)} minutes" }
  end
end