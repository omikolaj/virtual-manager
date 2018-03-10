# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180110115235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dealership_vehicles", force: :cascade do |t|
    t.integer "dealership_id"
    t.boolean "is_lot_ready", default: true
    t.string "buyer"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "permission"
  end

  create_table "dealerships", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.integer "dealership_id"
    t.boolean "omniauth", default: false
    t.integer "uid"
    t.integer "permission", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "manager", default: false
    t.string "password_digest"
    t.string "email"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.integer "dealership_vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
