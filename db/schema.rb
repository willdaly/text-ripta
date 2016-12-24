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

ActiveRecord::Schema.define(version: 20161224151956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.string "posted_text"
  end

  create_table "route_stops", force: :cascade do |t|
    t.integer "route_id"
    t.integer "stop_id"
    t.integer "order"
    t.index ["route_id"], name: "index_route_stops_on_route_id", using: :btree
    t.index ["stop_id"], name: "index_route_stops_on_stop_id", using: :btree
  end

  create_table "routes", force: :cascade do |t|
  end

  create_table "stops", force: :cascade do |t|
  end

  create_table "trips", force: :cascade do |t|
    t.integer "route_id"
    t.string  "trip_headsign"
    t.binary  "direction_id"
    t.index ["route_id"], name: "index_trips_on_route_id", using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "trip_id"
    t.integer "route_id"
    t.integer "stop_id"
    t.index ["route_id"], name: "index_vehicles_on_route_id", using: :btree
    t.index ["stop_id"], name: "index_vehicles_on_stop_id", using: :btree
    t.index ["trip_id"], name: "index_vehicles_on_trip_id", using: :btree
  end

  add_foreign_key "route_stops", "routes"
  add_foreign_key "route_stops", "stops"
  add_foreign_key "trips", "routes"
  add_foreign_key "vehicles", "routes"
  add_foreign_key "vehicles", "stops"
  add_foreign_key "vehicles", "trips"
end
