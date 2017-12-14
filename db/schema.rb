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

ActiveRecord::Schema.define(version: 20171207094936) do

  create_table "advertisements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "user_id", null: false
    t.integer "_type", null: false
    t.integer "cryptocurrency_type", null: false
    t.integer "legal_tender_type", null: false
    t.float "price", limit: 24, null: false
    t.integer "status", default: 0, null: false
    t.float "min_limit", limit: 24, null: false
    t.float "max_limit", limit: 24, null: false
    t.integer "time_limit", null: false
    t.boolean "alipay", default: false, null: false
    t.boolean "wxpay", default: false, null: false
    t.boolean "bankpay", default: false, null: false
    t.text "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "buyer_id", null: false
    t.integer "seller_id", null: false
    t.integer "advertisement_id", null: false
    t.integer "cryptocurrency_type", null: false
    t.float "cryptocurrency_amount", limit: 24, null: false
    t.float "legal_tender_amount", limit: 24, null: false
    t.integer "status", default: 0, null: false
    t.float "price", limit: 24, null: false
    t.float "service_charge", limit: 24, default: 0.0, null: false
    t.integer "payment"
    t.integer "locked_at"
    t.integer "time_limit", default: 15, null: false
    t.boolean "buyer_checked", default: false, null: false
    t.boolean "seller_checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "nickname", null: false
    t.string "password", null: false
    t.string "email", null: false
    t.string "mobile_number", limit: 20
    t.string "alipay_number"
    t.string "wx_number"
    t.string "bank_card_number"
    t.float "eth_balance", limit: 24, default: 0.0, null: false
    t.float "eth_locked_balance", limit: 24, default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
