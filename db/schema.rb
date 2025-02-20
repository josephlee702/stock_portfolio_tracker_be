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

ActiveRecord::Schema[7.1].define(version: 2025_02_14_034623) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.bigint "portfolio_id", null: false
    t.string "symbol"
    t.string "name"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "market_price"
    t.string "asset_type"
    t.index ["portfolio_id"], name: "index_assets_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.string "trade_type"
    t.decimal "amount"
    t.decimal "price"
    t.datetime "executed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "portfolio_id", null: false
    t.index ["asset_id"], name: "index_transactions_on_asset_id"
    t.index ["portfolio_id"], name: "index_transactions_on_portfolio_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assets", "portfolios"
  add_foreign_key "portfolios", "users"
  add_foreign_key "transactions", "assets"
  add_foreign_key "transactions", "portfolios"
end
