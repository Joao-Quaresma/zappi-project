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

ActiveRecord::Schema.define(version: 20180525200654) do

  create_table "announcement_categories", force: :cascade do |t|
    t.integer "announcement_id"
    t.integer "category_id"
  end

  create_table "announcement_comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "announcement_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "announcement_comments", ["announcement_id"], name: "index_announcement_comments_on_announcement_id"
  add_index "announcement_comments", ["user_id"], name: "index_announcement_comments_on_user_id"

  create_table "announcementnotifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "announcement_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "announcementnotifications", ["announcement_id"], name: "index_announcementnotifications_on_announcement_id"
  add_index "announcementnotifications", ["notified_by_id"], name: "index_announcementnotifications_on_notified_by_id"
  add_index "announcementnotifications", ["user_id"], name: "index_announcementnotifications_on_user_id"

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id"

  create_table "article_categories", force: :cascade do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  create_table "article_comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_comments", ["article_id"], name: "index_article_comments_on_article_id"
  add_index "article_comments", ["user_id"], name: "index_article_comments_on_user_id"

  create_table "articlenotifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "article_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "articlenotifications", ["article_id"], name: "index_articlenotifications_on_article_id"
  add_index "articlenotifications", ["notified_by_id"], name: "index_articlenotifications_on_notified_by_id"
  add_index "articlenotifications", ["user_id"], name: "index_articlenotifications_on_user_id"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "bookmarkee_id"
    t.string   "bookmarkee_type"
    t.integer  "bookmarker_id"
    t.string   "bookmarker_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "position"
  end

  add_index "bookmarks", ["bookmarkee_id", "bookmarkee_type", "bookmarker_id", "bookmarker_type"], name: "bookmarks_bookmarkee_bookmarker_idx", unique: true
  add_index "bookmarks", ["bookmarkee_id", "bookmarkee_type"], name: "bookmarks_bookmarkee_idx"
  add_index "bookmarks", ["bookmarker_id", "bookmarker_type"], name: "bookmarks_bookmarker_idx"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "socialpost_id"
    t.text     "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["socialpost_id"], name: "index_comments_on_socialpost_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "faq_categories", force: :cascade do |t|
    t.integer "faq_id"
    t.integer "category_id"
  end

  create_table "faq_comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "faq_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "faq_comments", ["faq_id"], name: "index_faq_comments_on_faq_id"
  add_index "faq_comments", ["user_id"], name: "index_faq_comments_on_user_id"

  create_table "faqnotifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "faq_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "faqnotifications", ["faq_id"], name: "index_faqnotifications_on_faq_id"
  add_index "faqnotifications", ["notified_by_id"], name: "index_faqnotifications_on_notified_by_id"
  add_index "faqnotifications", ["user_id"], name: "index_faqnotifications_on_user_id"

  create_table "faqs", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "socialpost_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",           default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "notifications", ["notified_by_id"], name: "index_notifications_on_notified_by_id"
  add_index "notifications", ["socialpost_id"], name: "index_notifications_on_socialpost_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "socialposts", force: :cascade do |t|
    t.string   "caption"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  add_index "socialposts", ["user_id"], name: "index_socialposts_on_user_id"

  create_table "to_do_lists", force: :cascade do |t|
    t.integer "user_id"
  end

  add_index "to_do_lists", ["user_id"], name: "index_to_do_lists_on_user_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false
    t.integer  "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "deleted_at"
    t.string   "job_role"
    t.string   "nickname"
    t.text     "resume"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
