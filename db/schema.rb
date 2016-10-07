# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_160_929_080_241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'average_caches', force: :cascade do |t|
    t.integer  'rater_id'
    t.string   'rateable_type'
    t.integer  'rateable_id'
    t.float    'avg', null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'flashcards', force: :cascade do |t|
    t.text     'front'
    t.text     'back'
    t.integer  'user_id'
    t.integer  'language_id'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.index ['language_id'], name: 'index_flashcards_on_language_id', using: :btree
    t.index ['user_id'], name: 'index_flashcards_on_user_id', using: :btree
  end

  create_table 'languages', force: :cascade do |t|
    t.string   'name'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_languages_on_user_id', using: :btree
  end

  create_table 'overall_averages', force: :cascade do |t|
    t.string   'rateable_type'
    t.integer  'rateable_id'
    t.float    'overall_avg', null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'rates', force: :cascade do |t|
    t.integer  'rater_id'
    t.string   'rateable_type'
    t.integer  'rateable_id'
    t.float    'stars', null: false
    t.string   'dimension'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(rateable_id rateable_type), name: 'index_rates_on_rateable_id_and_rateable_type', using: :btree
    t.index ['rater_id'], name: 'index_rates_on_rater_id', using: :btree
  end

  create_table 'rating_caches', force: :cascade do |t|
    t.string   'cacheable_type'
    t.integer  'cacheable_id'
    t.float    'avg',            null: false
    t.integer  'qty',            null: false
    t.string   'dimension'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(cacheable_id cacheable_type), name: 'index_rating_caches_on_cacheable_id_and_cacheable_type',
                                             using: :btree
  end

  create_table 'users', force: :cascade do |t|
    t.string   'name',                   default: '',    null: false
    t.string   'email',                  default: '',    null: false
    t.string   'encrypted_password',     default: '',    null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.boolean  'admin',                  default: false, null: false
    t.boolean  'banned',                 default: false, null: false
    t.integer  'points',                 default: 0,     null: false
    t.datetime 'created_at',                             null: false
    t.datetime 'updated_at',                             null: false
    t.string   'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string   'avatar'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true, using: :btree
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  end

  add_foreign_key 'flashcards', 'languages'
  add_foreign_key 'flashcards', 'users'
  add_foreign_key 'languages', 'users'
end
