# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.color = true
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.example_status_persistence_file_path = 'spec/examples.txt'

  DatabaseCleaner.strategy = :truncation

  config.after(:all) do
    DatabaseCleaner.clean
  end
end
