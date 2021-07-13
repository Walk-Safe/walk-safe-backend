5.times do 
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Lorem.word)
  5.times do
    user.contacts.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: Faker::PhoneNumber.cell_phone_in_e164)
  end 
  5.times do 
    user.trips.create(start_point: Faker::Address.full_address, end_point: Faker::Address.full_address, travel_mode: ['walking', 'bicycling', 'driving'].sample, eta: Faker::Number.number(digits: 5), eta_string: "#{Faker::Number.number(digits: 1)} hours and #{Faker::Number.number(digits: 2)} minutes")
  end
end
