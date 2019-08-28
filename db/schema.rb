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

ActiveRecord::Schema.define(version: 2019_08_28_122057) do

  create_table "appointments", force: :cascade do |t|
    t.integer "physician_id"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "appointment_date"
    t.integer "status", default: 0
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["physician_id"], name: "index_appointments_on_physician_id"
  end

  create_table "patients", force: :cascade do |t|
    t.integer "user_id"
    t.integer "patient_type", default: 0
    t.integer "ward_assigned"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "physicians", force: :cascade do |t|
    t.integer "user_id"
    t.string "speciality"
    t.string "shift"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_physicians_on_user_id"
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
    t.string "role", default: "general", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
