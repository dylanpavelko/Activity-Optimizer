# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_13_233257) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "time_slot_id"
    t.integer "location_id"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_activities_on_location_id"
    t.index ["project_id"], name: "index_activities_on_project_id"
    t.index ["time_slot_id"], name: "index_activities_on_time_slot_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_locations_on_project_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_participants_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.index ["project_id"], name: "index_time_slots_on_project_id"
  end

  add_foreign_key "activities", "locations"
  add_foreign_key "activities", "projects"
  add_foreign_key "activities", "time_slots"
  add_foreign_key "locations", "projects"
  add_foreign_key "participants", "projects"
  add_foreign_key "time_slots", "projects"
end
