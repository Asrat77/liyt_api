FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    business_name { "MyString" }
    business_email { "MyString" }
    primary_address { "" }
    secondary_address { "" }
  end
end
