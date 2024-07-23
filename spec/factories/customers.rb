FactoryBot.define do
  factory :customer do
    name { "MyString" }
    address { "MyString" }
    city { "MyString" }
    county { "MyString" }
    state { "MyString" }
    point_of_contact { "MyString" }
    contact_information { "MyString" }
    zip_code { "MyString" }
    last_check_in { "MyString" }
    next_check_in { "2024-07-22" }
    notes { "MyText" }
    interest_level { 1 }
    bar { "MyString" }
    liquor_store { false }
  end
end
