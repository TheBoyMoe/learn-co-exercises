# load the gems
require 'bundler'
Bundler.require

# tell sinatra where to find your controllers
# require_relative './../app/controllers/about_controller'
# require_relative './../app/controllers/application_controller'

ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

# create the database connection
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

# tell sinatra where to find all your app files
# pass an absolute path
require_all './app'
