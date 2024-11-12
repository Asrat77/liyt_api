# db/seeds.rb

# Create sample users and drivers if they don't exist
user = FactoryBot.create(:user)
driver = FactoryBot.create(:driver)

# Create 3 sample orders
3.times do
  FactoryBot.create(:order, user: user, driver: driver)
end

puts "Created 3 sample orders."
