require_relative './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
  # raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

# override 'post' actions in form submissions with whatever the value of the 'value' attribute in 'input field' - req'd for 'patch' & 'delete'
use Rack::MethodOverride

run ApplicationController
