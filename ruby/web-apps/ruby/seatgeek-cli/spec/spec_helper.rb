require "bundler/setup"
require "seatgeek_cli"
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end


RSpec.configure do |config|
  config.around(:each) do |example|
    VCR.use_cassette("seatgeek-events") do
      example.run
    end
  end
end
