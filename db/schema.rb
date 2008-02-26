# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "cities", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name",                                                                     :null => false
    t.integer  "city_id",                                                                  :null => false
    t.integer  "food_type_id",                                            :default => 0
    t.integer  "pricing",                                                 :default => 0
    t.integer  "rating",       :limit => 2, :precision => 2, :scale => 0, :default => 0
    t.string   "homepage",                                                                 :null => false
    t.string   "address",                                                                  :null => false
    t.decimal  "lat",                       :precision => 9, :scale => 6, :default => 0.0
    t.decimal  "lon",                       :precision => 9, :scale => 6, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
