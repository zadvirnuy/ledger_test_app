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

ActiveRecord::Schema.define(version: 2020_04_27_120532) do

  create_table "ledgers", force: :cascade do |t|
    t.string "name", null: false
    t.float "starting_balance", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tag_connections", force: :cascade do |t|
    t.integer "tag_id"
    t.string "subject_type"
    t.integer "subject_id"
    t.index ["subject_type", "subject_id"], name: "index_tag_connections_on_subject_type_and_subject_id"
    t.index ["tag_id"], name: "index_tag_connections_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "ledger_id", null: false
    t.float "amount", default: 0.0, null: false
    t.datetime "date"
    t.string "tr_type", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ledger_id"], name: "index_transactions_on_ledger_id"
  end

  add_foreign_key "transactions", "ledgers"
end
