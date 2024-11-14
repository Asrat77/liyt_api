class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :business_name, presence: true
  validates :email, presence: true, uniqueness: true

  def primary_address=(coordinates)
    if coordinates.is_a?(Hash) && coordinates["latitude"].present? && coordinates["longitude"].present?
      self[:primary_address] = { "latitude" => coordinates["latitude"], "longitude" => coordinates["longitude"] }
    else
    self[:primary_address] = { "latitude" => nil, "longitude" => nil }

    end
  end

  def secondary_address=(coordinates)
    if coordinates.is_a?(Hash) && coordinates["latitude"].present? && coordinates["longitude"].present?
      self[:secondary_address] = { "latitude" => coordinates["latitude"], "longitude" => coordinates["longitude"] }
    else
      self[:secondary_address] = nil
    end
  end
end
