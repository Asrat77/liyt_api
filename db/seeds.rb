# db/seeds.rb

# Create sample users and drivers if they don't exist
user = FactoryBot.create(:user)
driver = FactoryBot.create(:driver)

# Create 3 sample orders
6.times do
  FactoryBot.create(:order, user: user, driver: driver)
end

puts "Created 6 sample orders."
