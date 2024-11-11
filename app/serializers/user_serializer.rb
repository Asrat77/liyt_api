class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :email, :password_digest, :business_name, :business_email, :primary_address, :secondary_address
end
