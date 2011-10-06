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

ActiveRecord::Schema.define(:version => 20111005204001) do

  create_table "friendships", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "headline",        :limit => 50
    t.string   "gender",          :limit => 1
    t.date     "birthday"
    t.string   "phone",           :limit => 50
    t.string   "location",        :limit => 50
    t.string   "small_image_url"
    t.string   "facebook_id"
    t.string   "facebook_url"
    t.string   "twitter_id"
    t.string   "twitter_url"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_image_url"
    t.string   "address",         :limit => 100
    t.string   "address2",        :limit => 100
    t.string   "city",            :limit => 100
    t.string   "state",           :limit => 2
    t.string   "postal_code",     :limit => 10
  end

  create_table "themes", :force => true do |t|
    t.integer  "profile_id"
    t.string   "bg_image"
    t.boolean  "bg_image_tiled",                       :default => false
    t.string   "bg_image_byline",       :limit => 100
    t.string   "bg_class",              :limit => 25
    t.string   "bg_color_top",          :limit => 7
    t.string   "bg_color_bottom",       :limit => 7
    t.string   "box_pos",               :limit => 25
    t.string   "box_bg_color",          :limit => 7
    t.float    "box_bg_opacity"
    t.string   "name_font_family",      :limit => 50
    t.string   "name_font_weight",      :limit => 10
    t.string   "name_font_style",       :limit => 10
    t.string   "name_font_variant",     :limit => 10
    t.integer  "name_line_height"
    t.integer  "name_size"
    t.string   "name_color",            :limit => 7
    t.string   "headline_font_family",  :limit => 50
    t.string   "headline_font_weight",  :limit => 10
    t.string   "headline_font_style",   :limit => 10
    t.string   "headline_font_variant", :limit => 10
    t.integer  "headline_line_height"
    t.integer  "headline_size"
    t.string   "headline_color",        :limit => 7
    t.string   "bio_font_family",       :limit => 50
    t.string   "bio_font_weight",       :limit => 10
    t.string   "bio_font_style",        :limit => 10
    t.string   "bio_font_variant",      :limit => 10
    t.integer  "bio_line_height"
    t.integer  "bio_size"
    t.string   "bio_color",             :limit => 7
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider",               :limit => 50
    t.string   "uid",                    :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.boolean  "validated",                             :default => false
    t.string   "timezone",               :limit => 50
    t.string   "fb_token",               :limit => 100
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
