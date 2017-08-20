require 'sqlite3'
require_relative 'song'

DB = {:conn => SQLite3::Database.new("songs.db")}
