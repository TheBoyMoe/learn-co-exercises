# load the gems
require 'bundler'
Bundler.require

# tell sinatra where to find your controllers
# require_relative './../app/controllers/about_controller'
# require_relative './../app/controllers/application_controller'

# pass an absolute path
require_all './app'
 
