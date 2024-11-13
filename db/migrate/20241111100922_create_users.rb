class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email, null: false
      t.string :password_digest
      t.string :business_name
      t.string :business_email
      t.json :primary_address
      t.json :secondary_address

      t.timestamps
    end
  end
end
