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

ActiveRecord::Schema.define(version: 20190924213641) do

  create_table "facebooks", force: :cascade do |t|
    t.string "token"
    t.datetime "token_expiration"
    t.string "link"
    t.string "email"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forbidden_matches", force: :cascade do |t|
    t.integer "friend_1_id"
    t.integer "friend_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_amazon_lists", force: :cascade do |t|
    t.string "external_id", null: false
    t.integer "friend_id", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_amazon_wishes", force: :cascade do |t|
    t.string "external_id", null: false
    t.integer "friend_id", null: false
    t.integer "year", null: false
    t.integer "friend_amazon_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_matches", force: :cascade do |t|
    t.integer "giver_id"
    t.integer "recipient_id"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_messages", force: :cascade do |t|
    t.integer "friend_match_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "content"
    t.integer "year"
    t.integer "mailgun_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sent"
    t.boolean "read"
  end

  create_table "friends", force: :cascade do |t|
    t.string "name"
    t.integer "generation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
  end

  create_table "generations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gifts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "wish_id"
    t.integer "giver_id"
    t.integer "recipient_id"
    t.text "purchase_status"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wishes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "friend_id"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "friend_amazon_wish_id"
  end

end
