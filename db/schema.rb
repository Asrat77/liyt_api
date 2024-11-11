# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_11_102054) do
  create_table "drivers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.integer "vehicle_type", null: false
    t.string "license_plate_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "business_name", null: false
    t.string "business_email"
    t.json "primary_address"
    t.json "secondary_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
