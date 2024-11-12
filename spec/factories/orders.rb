FactoryBot.define do
  factory :order do
    user
    driver
    status { 1 }
    origin { Faker::Address.full_address }
    destination { Faker::Address.full_address }
    price { Faker::Commerce.price }
    customer_name { Faker::Name.name }
    customer_phone_number { Faker::PhoneNumber.phone_number }
  end
end