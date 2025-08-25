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

ActiveRecord::Schema[8.0].define(version: 2025_08_17_044140) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "hirings", force: :cascade do |t|
    t.integer "hired_by_id"
    t.string "service_request"
    t.integer "tirador_id"
    t.boolean "confirmed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hired_by_id"], name: "index_hirings_on_hired_by_id"
    t.index ["tirador_id"], name: "index_hirings_on_tirador_id"
  end

  create_table "more_infos", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.string "active_service"
    t.boolean "is_verified", default: false
    t.float "average_rating", default: 0.0
    t.boolean "is_hired", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_more_infos_on_profile_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "tirador_id"
    t.integer "hired_by_id"
    t.string "title"
    t.text "message"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hired_by_id"], name: "index_notifications_on_hired_by_id"
    t.index ["tirador_id"], name: "index_notifications_on_tirador_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.date "birth_date"
    t.string "sex"
    t.string "province"
    t.string "town"
    t.string "barangay"
    t.string "street"
    t.string "current_location"
    t.string "primary_service"
    t.string "secondary_service"
    t.string "tertiary_service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "tirador_id"
    t.integer "client_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["tirador_id"], name: "index_reviews_on_tirador_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "mobile_number"
    t.string "email_address"
    t.string "username"
    t.string "password_digest"
    t.string "api_token"
    t.datetime "api_token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fcm_token"
    t.index ["api_token"], name: "index_users_on_api_token", unique: true
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "more_infos", "profiles"
  add_foreign_key "profiles", "users"
end
