FactoryBot.define do 
  factory :contact do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name } 
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end
