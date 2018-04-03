require "rails_helper"

RSpec.describe do
  it "should require the bootstrap-addon file in the application manifest" do
    expect(File.read("app/assets/stylesheets/application.css")).to include("*= require bootstrap-addon")
  end

  it "should require the pages file in the application manifest" do
    expect(File.read("app/assets/stylesheets/application.css")).to include("*= require pages")
  end

  it "should require the hidden_styles file in the application manifest" do
    expect(File.read("app/assets/stylesheets/application.css")).to include("*= require hidden_styles")
  end
end
