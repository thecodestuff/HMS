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

ActiveRecord::Schema.define(version: 2019_10_08_072239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "api_maps", force: :cascade do |t|
    t.string "name"
    t.decimal "lat"
    t.decimal "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "physician_id"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "appointment_date"
    t.integer "status", default: 0
    t.datetime "start_time"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["physician_id"], name: "index_appointments_on_physician_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "patient_id"
    t.decimal "amount", default: "0.0"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "bill_date"
    t.date "admit_on"
    t.date "discharged"
    t.integer "days"
    t.integer "appointments"
    t.string "transactionId", default: ""
    t.integer "ward_rate", default: 100
    t.decimal "appointment_charge", default: "0.0"
    t.index ["patient_id"], name: "index_invoices_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "user_id"
    t.integer "patient_type", default: 0
    t.string "ward_assigned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "admit_date"
    t.date "dischagre_on"
    t.integer "status", default: 0
    t.integer "ward_occupancy_detail_id", default: 0
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "physicians", force: :cascade do |t|
    t.integer "user_id"
    t.string "speciality"
    t.string "shift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "charge", default: "100.0"
    t.decimal "charge_at_weekend"
    t.index ["user_id"], name: "index_physicians_on_user_id"
  end

  create_table "sample_data_tables", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "amount"
    t.integer "month"
  end

  create_table "samples", force: :cascade do |t|
    t.integer "patient_id"
    t.decimal "amount"
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "civil_id", default: "", null: false
    t.integer "previlige_level", default: 0, null: false
    t.boolean "admin", default: false
    t.string "department", default: "general"
    t.string "phone"
    t.string "blood_group"
    t.integer "age"
    t.string "house_no"
    t.string "street"
    t.string "locality"
    t.string "city"
    t.string "state"
    t.string "pincode"
    t.string "country"
    t.integer "role", default: 0
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "ward_occupancy_details", force: :cascade do |t|
    t.string "ward_name"
    t.integer "ward_type", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
