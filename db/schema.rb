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

ActiveRecord::Schema.define(:version => 20121104161425) do

  create_table "alerts", :force => true do |t|
    t.string  "type",        :null => false
    t.string  "content",     :null => false
    t.integer "location_id", :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string  "name",        :null => false
    t.string  "type",        :null => false
    t.string  "address",     :null => false
    t.string  "city",        :null => false
    t.string  "state",       :null => false
    t.string  "phone",       :null => false
    t.string  "zip",         :null => false
    t.integer "location_id", :null => false
  end

  create_table "counties", :force => true do |t|
    t.string "name",                    :null => false
    t.string "fip",                     :null => false
    t.string "state_code", :limit => 2
  end

  create_table "counties_locations", :id => false, :force => true do |t|
    t.integer "county_id",   :null => false
    t.integer "location_id", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string  "city",      :null => false
    t.string  "state",     :null => false
    t.integer "county_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_hash"
    t.string   "latlng"
    t.integer  "location_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "shelters", :force => true do |t|
    t.string  "name",        :null => false
    t.integer "location_id", :null => false
  end

  create_table "zipcodes", :force => true do |t|
    t.string  "code",      :null => false
    t.integer "county_id"
  end

end
