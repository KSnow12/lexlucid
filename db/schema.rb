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

ActiveRecord::Schema.define(version: 20180224192624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bullet_points", force: :cascade do |t|
    t.text "human_title"
    t.text "human_description"
    t.text "lawyer_title"
    t.text "lawyer_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_types", force: :cascade do |t|
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.text "description"
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "document_type_id"
    t.index ["document_type_id"], name: "index_documents_on_document_type_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.text "description"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bullet_point_id"
    t.index ["bullet_point_id"], name: "index_ratings_on_bullet_point_id"
    t.index ["review_id"], name: "index_ratings_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "document_id"
    t.index ["document_id"], name: "index_reviews_on_document_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "website"
    t.text "description"
    t.string "company_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "documents", "document_types"
  add_foreign_key "ratings", "bullet_points"
  add_foreign_key "ratings", "reviews"
  add_foreign_key "reviews", "documents"
end
