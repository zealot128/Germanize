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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110313085723) do

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.text     "options"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", :force => true do |t|
    t.integer  "word_id"
    t.integer  "exercise_id"
    t.integer  "level"
    t.datetime "next_visit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "stats"
  end

  add_index "levels", ["exercise_id"], :name => "index_levels_on_exercise_id"
  add_index "levels", ["level"], :name => "index_levels_on_level"
  add_index "levels", ["next_visit"], :name => "index_levels_on_next_visit"
  add_index "levels", ["word_id"], :name => "index_levels_on_word_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score"
  end

  create_table "words", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "translation"
    t.text     "examples"
    t.string   "wordform"
    t.text     "grammar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "synonyms"
  end

end
