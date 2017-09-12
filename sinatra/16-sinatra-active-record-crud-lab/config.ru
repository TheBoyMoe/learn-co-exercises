require './config/environment'
require './app/controllers/application_controller'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# override 'post' actions in form submissions with whatever the value of the 'value' attribute in 'input field'
use Rack::MethodOverride

run ApplicationController
