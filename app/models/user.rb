class User < ApplicationRecord
  has_secure_password
  def primary_address=(coordinates)
      self[:primary_address] = { "latitude" => coordinates[0], "longitude" => coordinates[1] }
    end

    # Set the secondary_address as a hash with latitude and longitude
    def secondary_address=(coordinates)
      self[:secondary_address] = { "latitude" => coordinates[0], "longitude" => coordinates[1] }
    end
end
