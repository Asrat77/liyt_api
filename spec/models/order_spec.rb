require 'rails_helper'

RSpec.describe Order, type: :model do
  it "has a valid factory" do
    expect(create(:order)).to be_valid
  end

  it "validates that customer name cannot be nil" do
    order = build(:order, customer_name: nil)
    expect(order).not_to be_valid
  end

  it "validates that origin cannot be nil" do
    order = build(:order, origin: nil)
    expect(order).not_to be_valid
  end

  it "validates that destination cannot be nil" do
    order = build(:order, destination: nil)
    expect(order).not_to be_valid
  end

  it "validates that price cannot be nil" do
    order = build(:order, price: nil)
    expect(order).not_to be_valid
  end

  it "validates that price must be greater than or equal to 0" do
    order = build(:order, price: -1)
    expect(order).not_to be_valid
  end

  it "validates that status is included in the defined enum" do
    order = build(:order, status: nil)
    expect(order).not_to be_valid

    order.status = :pending
    expect(order).to be_valid

    order.status = :scheduled
    expect(order).to be_valid

    order.status = :in_progress
    expect(order).to be_valid

    order.status = :delivered
    expect(order).to be_valid
  end

  it "validates that driver can be nil if the order status is not in_progress" do
    order = build(:order, status: :pending, driver: nil)
    expect(order).to be_valid  # Should be valid without a driver
  end
end
