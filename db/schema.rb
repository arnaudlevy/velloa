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

ActiveRecord::Schema.define(version: 2020_07_25_145219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.text "url"
    t.string "title"
    t.text "text"
    t.text "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "analysis"
    t.date "published_at"
    t.index ["source_id"], name: "index_articles_on_source_id"
  end

  create_table "articles_themes", id: false, force: :cascade do |t|
    t.bigint "theme_id", null: false
    t.bigint "article_id", null: false
    t.index ["article_id", "theme_id"], name: "index_articles_themes_on_article_id_and_theme_id"
    t.index ["theme_id", "article_id"], name: "index_articles_themes_on_theme_id_and_article_id"
  end

  create_table "letters", force: :cascade do |t|
    t.date "starting_at"
    t.date "ending_at"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image"
    t.string "country_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "name"
    t.text "keywords"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "articles", "sources"
end
