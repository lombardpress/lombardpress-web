# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150518204814) do

  create_table "access_points", force: :cascade do |t|
    t.string   "itemid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "commentaryid"
  end

  create_table "access_points_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "access_point_id"
  end

  add_index "access_points_users", ["access_point_id"], name: "index_access_points_users_on_access_point_id"
  add_index "access_points_users", ["user_id"], name: "index_access_points_users_on_user_id"

  create_table "access_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "itemid"
    t.string   "commentaryid"
    t.string   "note"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "status"
  end

  add_index "access_requests", ["user_id"], name: "index_access_requests_on_user_id"

  create_table "articles", force: :cascade do |t|
    t.string   "article_name"
    t.string   "xml_file"
    t.string   "xslt_file"
    t.integer  "setting_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "articles", ["setting_id"], name: "index_articles_on_setting_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "comment"
    t.string   "itemid"
    t.string   "commentaryid"
    t.string   "pid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "body"
    t.string   "commentaryid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "settings", force: :cascade do |t|
    t.string   "commentaryid"
    t.string   "logo"
    t.text     "title"
    t.text     "bannermessage"
    t.boolean  "blog"
    t.string   "default_ms_image"
    t.string   "dark_color"
    t.string   "light_color"
    t.string   "commentarydirname"
    t.integer  "article_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "settings", ["article_id"], name: "index_settings_on_article_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
