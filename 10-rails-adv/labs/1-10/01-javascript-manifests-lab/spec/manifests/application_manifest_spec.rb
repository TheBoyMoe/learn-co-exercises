require "rails_helper"

RSpec.describe do
  it "should require the alert maker file in the application manifest" do
    expect(File.read("app/assets/javascripts/application.js")).to include("//= require alert_maker")
  end

  it "should require the wrong place wrong time file in the application manifest" do
    expect(File.read("app/assets/javascripts/application.js")).to include("//= require wrong_place_wrong_time")
  end

  it "should require the main file in the application manifest" do
    expect(File.read("app/assets/javascripts/application.js")).to include("//= require main")
  end
end