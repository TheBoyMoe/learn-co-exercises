# load gems
require 'bundler'
Bundler.require

require_all 'lib'

require 'open-uri'

DB = {:conn => SQLite3::Database.new('db/roommate.db')}
