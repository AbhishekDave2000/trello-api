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

ActiveRecord::Schema[8.1].define(version: 2026_07_01_010232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["member", "admin", "guest"]

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "avatar_url"
    t.string "bio"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "email_verified", default: false
    t.datetime "email_verified_at"
    t.datetime "last_seen_at"
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", default: "member", null: false
    t.string "time_zone", default: "UTC"
    t.datetime "updated_at", null: false
    t.string "user_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.bigint "owner_id", null: false
    t.string "slug"
    t.datetime "updated_at", null: false
    t.boolean "visibility", default: true, null: false
    t.index ["owner_id"], name: "index_workspaces_on_owner_id"
  end

  add_foreign_key "workspaces", "users", column: "owner_id"
end
