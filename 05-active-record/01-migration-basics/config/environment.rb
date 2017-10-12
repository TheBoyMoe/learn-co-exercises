require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'


require 'bundler/setup'
Bundler.require


# connect to the database
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/artists.sqlite'
)

require_relative "../lib/artist.rb"
