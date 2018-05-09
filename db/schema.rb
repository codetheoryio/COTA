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

ActiveRecord::Schema.define(version: 20180509065657) do

  create_table "answers", force: :cascade do |t|
    t.integer  "quiz_candidate_id", limit: 4
    t.integer  "question_id",       limit: 4
    t.integer  "option_id",         limit: 4
    t.text     "answer_body",       limit: 65535
    t.text     "remarks",           limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "answers", ["option_id"], name: "index_answers_on_option_id", using: :btree
  add_index "answers", ["quiz_candidate_id"], name: "index_answers_on_quiz_candidate_id", using: :btree

  create_table "candidates", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.string   "phone",            limit: 255
    t.string   "applied_position", limit: 255
    t.decimal  "experience",                   precision: 10
    t.string   "status",           limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "options", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "body",        limit: 65535
    t.boolean  "is_correct"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "question_sets", force: :cascade do |t|
    t.integer  "quiz_id",        limit: 4
    t.integer  "question_count", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "question_sets", ["quiz_id"], name: "index_question_sets_on_quiz_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "quiz_candidates", force: :cascade do |t|
    t.integer  "quiz_id",      limit: 4
    t.integer  "candidate_id", limit: 4
    t.string   "status",       limit: 255
    t.text     "remarks",      limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "quiz_candidates", ["candidate_id"], name: "index_quiz_candidates_on_candidate_id", using: :btree
  add_index "quiz_candidates", ["quiz_id"], name: "index_quiz_candidates_on_quiz_id", using: :btree

  create_table "quizzes", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "job_title",    limit: 255
    t.text     "introduction", limit: 65535
    t.text     "rules",        limit: 65535
    t.integer  "time_limit",   limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255, default: "", null: false
    t.string   "last_name",              limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "quiz_candidates"
  add_foreign_key "options", "questions"
  add_foreign_key "question_sets", "quizzes"
  add_foreign_key "quiz_candidates", "candidates"
  add_foreign_key "quiz_candidates", "quizzes"
end
