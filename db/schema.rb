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

ActiveRecord::Schema.define(version: 2018_04_17_150127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "itineraries", force: :cascade do |t|
    t.datetime "leave_at", null: false
    t.integer "seats"
    t.string "comfort"
    t.text "description"
    t.integer "price"
    t.string "title"
    t.boolean "smoking", default: false
    t.string "name"
    t.integer "age"
    t.string "email"
    t.string "phone"
    t.string "creation_token"
    t.string "edition_token"
    t.string "deletion_token"
    t.integer "state", default: 0
    t.string "creation_ip"
    t.string "deletion_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "kind"
    t.integer "rank"
    t.bigint "itinerary_id"
    t.geometry "lonlat", limit: {:srid=>0, :type=>"st_point"}
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "zipcode"
    t.string "country_iso_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itinerary_id"], name: "index_locations_on_itinerary_id"
  end

  add_foreign_key "locations", "itineraries"
end
