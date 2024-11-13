class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :business_name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :primary_address, presence: true

  def primary_address=(coordinates)
    if coordinates.present?
      self[:primary_address] = { "latitude" => coordinates[0], "longitude" => coordinates[1] }
    else
      self[:primary_address] = nil
    end
  end

  def secondary_address=(coordinates)
    if coordinates.present?
      self[:secondary_address] = { "latitude" => coordinates[0], "longitude" => coordinates[1] }
    else
      self[:secondary_address] = nil
    end
  end
end
