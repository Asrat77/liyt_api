require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "validates that first name cannot be nil" do
    user = build(:user, first_name: nil)
    expect(user).not_to be_valid
  end

  it "validates that last name cannot be nil" do
    user = build(:user, last_name: nil)
    expect(user).not_to be_valid
  end

  it "validates that phone number cannot be nil" do
    user = build(:user, phone_number: nil)
    expect(user).not_to be_valid
  end

  it "validates that email cannot be nil" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "validates that business name cannot be nil" do
    user = build(:user, business_name: nil)
    expect(user).not_to be_valid
  end
end
