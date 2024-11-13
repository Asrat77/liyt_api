require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "validates that email is unique" do
    user1 = create(:user)
    user2 = build(:user, email: user1.email)
    expect(user2).not_to be_valid
  end

  it "validates that email cannot be nil" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end
end
