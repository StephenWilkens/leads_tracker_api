FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.community }
    state { Faker::Address.state }
    point_of_contact { Faker::Name.first_name }
    contact_information { Faker::PhoneNumber.phone_number }
    zip_code { Faker::Address.zip_code }
    last_check_in { Faker::Date.between(from: '2024-03-01', to: Date.today) }
    next_check_in { Faker::Date.between(from: Date.today, to: 1.month.from_now) }
    notes { Faker::Lorem.paragraph }
    interest_level { Faker::Number.between(from: 0, to: 5) }
    bar { Faker::Boolean.boolean }
    liquor_store { Faker::Boolean.boolean }
  end
end
