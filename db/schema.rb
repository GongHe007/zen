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

ActiveRecord::Schema.define(version: 20171229055429) do

  create_table "advertisements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "user_id", null: false
    t.integer "_type", null: false
    t.integer "cryptocurrency_type", null: false
    t.integer "legal_tender_type", null: false
    t.float "premium", limit: 24, null: false
    t.integer "status", default: 0, null: false
    t.float "min_limit", limit: 24
    t.float "max_limit", limit: 24
    t.float "min_price", limit: 24
    t.float "max_price", limit: 24
    t.integer "time_limit", null: false
    t.boolean "alipay", default: false, null: false
    t.boolean "wxpay", default: false, null: false
    t.boolean "bankpay", default: false, null: false
    t.string "alipay_number"
    t.string "wx_number"
    t.string "bank_card_number"
    t.text "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "certification", default: false, null: false
    t.index ["_type"], name: "index_advertisements_on__type"
    t.index ["cryptocurrency_type"], name: "index_advertisements_on_cryptocurrency_type"
    t.index ["legal_tender_type"], name: "index_advertisements_on_legal_tender_type"
    t.index ["status"], name: "index_advertisements_on_status"
    t.index ["user_id"], name: "index_advertisements_on_user_id"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "buyer_id", null: false
    t.integer "seller_id", null: false
    t.integer "advertisement_id", null: false
    t.integer "cryptocurrency_type", null: false
    t.integer "legal_tender_type", null: false
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
    t.index ["advertisement_id"], name: "index_orders_on_advertisement_id"
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["cryptocurrency_type"], name: "index_orders_on_cryptocurrency_type"
    t.index ["legal_tender_type"], name: "index_orders_on_legal_tender_type"
    t.index ["seller_id"], name: "index_orders_on_seller_id"
    t.index ["status"], name: "index_orders_on_status"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "nickname", null: false
    t.string "encrypted_password", null: false
    t.string "token", null: false
    t.string "email", null: false
    t.string "mobile_number", limit: 20
    t.float "eth_balance", limit: 24, default: 0.0, null: false
    t.float "eth_locked_balance", limit: 24, default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
