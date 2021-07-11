# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do 
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Lorem.word)
  5.times do
    user.contacts.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone_number: Faker::PhoneNumber.cell_phone_in_e164)
  end 
  5.times do 
    user.trips.create(start_point: Faker::Address.full_address, end_point: Faker::Address.full_address, travel_mode: 'walking', start_lat: Faker::Address.latitude, start_lon: Faker::Address.longitude, end_lat: Faker::Address.latitude, end_lon: Faker::Address.longitude, eta: 500)
  end
end