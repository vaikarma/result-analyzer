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

ActiveRecord::Schema[8.1].define(version: 2026_05_07_163117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "daily_statistics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "daily_high"
    t.integer "daily_low"
    t.date "date"
    t.integer "result_count"
    t.string "subject"
    t.datetime "updated_at", null: false
  end

  create_table "monthly_averages", force: :cascade do |t|
    t.float "average_daily_high"
    t.float "average_daily_low"
    t.datetime "created_at", null: false
    t.string "month"
    t.string "subject"
    t.integer "total_result_count"
    t.datetime "updated_at", null: false
  end

  create_table "test_results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "marks"
    t.string "student_name"
    t.string "subject"
    t.datetime "submitted_at"
    t.datetime "updated_at", null: false
  end
end
