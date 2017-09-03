ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Type `rake -T` on your command line to see the available rake tasks.

desc 'Console for my application'
task :console do
  Pry.start
end
