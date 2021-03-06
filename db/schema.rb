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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141019161608) do

  create_table "event_choices", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_choices", ["event_id"], :name => "index_event_choices_on_event_id"
  add_index "event_choices", ["user_id"], :name => "index_event_choices_on_user_id"

  create_table "event_suggestions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.string   "status",      :default => "open"
    t.integer  "host_id"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "category"
    t.date     "date"
  end

  add_index "event_suggestions", ["host_id"], :name => "index_event_suggestions_on_host_id"

  create_table "event_venues", :force => true do |t|
    t.integer  "event_suggestion_id"
    t.integer  "venue_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "description"
  end

  add_index "event_venues", ["event_suggestion_id"], :name => "index_event_venues_on_event_suggestion_id"
  add_index "event_venues", ["venue_id"], :name => "index_event_venues_on_venue_id"

  create_table "events", :force => true do |t|
    t.integer  "event_suggestion_id"
    t.date     "date"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "events", ["event_suggestion_id"], :name => "index_events_on_event_suggestion_id"

  create_table "invitations", :force => true do |t|
    t.integer  "event_suggestion_id"
    t.integer  "invitee_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "invitations", ["event_suggestion_id"], :name => "index_invitations_on_event_suggestion_id"
  add_index "invitations", ["invitee_id"], :name => "index_invitations_on_invitee_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "role",                   :default => "basic_user"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "email",                  :default => "",           :null => false
    t.string   "encrypted_password",     :default => "",           :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,            :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
