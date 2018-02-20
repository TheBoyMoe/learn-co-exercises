require 'support/helpers/controller_helpers'
require 'support/helpers/session_helpers'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, type: :controller
  config.include Features::SessionHelpers, type: :feature
end
