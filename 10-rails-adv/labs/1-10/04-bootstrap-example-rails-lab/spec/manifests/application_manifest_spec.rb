require "rails_helper"

RSpec.describe do
  it "should require the bootstrap imports in the application CSS manifest" do
    expect(File.read("app/assets/stylesheets/application.scss")).to include('@import "bootstrap-sprockets";')
    expect(File.read("app/assets/stylesheets/application.scss")).to include('@import "bootstrap";')
  end
end
