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

ActiveRecord::Schema[8.1].define(version: 2026_11_18_104751) do
  create_table "kit_variants", force: :cascade do |t|
    t.integer "kit_id", null: false
    t.integer "variant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_id"], name: "index_kit_variants_on_kit_id"
    t.index ["variant_id"], name: "index_kit_variants_on_variant_id"
  end

  create_table "kits", force: :cascade do |t|
    t.integer "shop_id", null: false
    t.string "title"
    t.integer "price_cents"
    t.datetime "published_at"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_kits_on_shop_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "shop_id", null: false
    t.integer "kit_id", null: false
    t.integer "voucher_id", null: false
    t.string "customer_email"
    t.integer "total_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_id"], name: "index_orders_on_kit_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
    t.index ["voucher_id"], name: "index_orders_on_voucher_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_shops_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["shop_id"], name: "index_users_on_shop_id"
  end

  create_table "variants", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "size"
    t.integer "price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "voucher_bundles", force: :cascade do |t|
    t.integer "kit_id", null: false
    t.integer "expected_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kit_id"], name: "index_voucher_bundles_on_kit_id"
  end

  create_table "vouchers", force: :cascade do |t|
    t.integer "voucher_bundle_id", null: false
    t.string "code"
    t.string "assigned_to_email"
    t.datetime "notified_at"
    t.datetime "redeemed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deactivated_at"
    t.index ["code"], name: "index_vouchers_on_code", unique: true
    t.index ["voucher_bundle_id"], name: "index_vouchers_on_voucher_bundle_id"
  end

  add_foreign_key "kit_variants", "kits"
  add_foreign_key "kit_variants", "variants"
  add_foreign_key "kits", "shops"
  add_foreign_key "orders", "kits"
  add_foreign_key "orders", "shops"
  add_foreign_key "orders", "vouchers"
  add_foreign_key "products", "shops"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "shops"
  add_foreign_key "variants", "products"
  add_foreign_key "voucher_bundles", "kits"
  add_foreign_key "vouchers", "voucher_bundles"
end
