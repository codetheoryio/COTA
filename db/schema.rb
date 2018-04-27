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

ActiveRecord::Schema.define(version: 20180427043009) do

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
    t.integer  "taggable_id",    limit: 4
    t.string   "taggable_type",  limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "question_sets", ["quiz_id"], name: "index_question_sets_on_quiz_id", using: :btree
  add_index "question_sets", ["taggable_type", "taggable_id"], name: "index_question_sets_on_taggable_type_and_taggable_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.text     "body",          limit: 65535
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "questions", ["taggable_type", "taggable_id"], name: "index_questions_on_taggable_type_and_taggable_id", using: :btree

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

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "answers", "options"
  add_foreign_key "answers", "quiz_candidates"
  add_foreign_key "options", "questions"
  add_foreign_key "question_sets", "quizzes"
  add_foreign_key "quiz_candidates", "candidates"
  add_foreign_key "quiz_candidates", "quizzes"
  add_foreign_key "taggings", "tags"
end
