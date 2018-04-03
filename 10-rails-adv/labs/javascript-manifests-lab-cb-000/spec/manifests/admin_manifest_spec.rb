require "rails_helper"

RSpec.describe do
  it "should not require the main file in the admin manifest" do
    expect(File.read("app/assets/javascripts/admin.js")).not_to include("//= require main")
  end

  it "should require the hello world file in the admin manifest" do
    expect(File.read("app/assets/javascripts/admin.js")).to include("//= require hello_world")
  end

  it "should require the hello world file in the admin manifest" do
    expect(File.read("app/assets/javascripts/admin.js")).to include("//= require doesn_nothing")
  end
end