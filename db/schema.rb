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

ActiveRecord::Schema.define(version: 2020_03_02_150545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "idiots", force: :cascade do |t|
    t.string "name"
    t.datetime "death_date"
    t.integer "r_star_id"
    t.text "pazient_diagnos"
    t.text "comment"
    t.boolean "agressive", default: false
    t.integer "mom_joke", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "imported", default: false
    t.boolean "auto_kick", default: false
    t.boolean "warn_me", default: false
    t.boolean "freeze_player", default: false
    t.boolean "blame", default: false
    t.boolean "explode", default: false
    t.integer "cheats", default: 0
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_idiots_on_discarded_at"
  end

end
