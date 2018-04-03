require "rails_helper"

RSpec.describe do
  it "should not require the posts file in the admin manifest" do
    expect(File.read("app/assets/stylesheets/admin.css")).not_to include("*= require posts")
  end

  it "should require the bootstrap-addon file in the admin manifest" do
    expect(File.read("app/assets/stylesheets/admin.css")).to include("*= require bootstrap-addon")
  end

  it "should require the jquery-addon file in the admin manifest" do
    expect(File.read("app/assets/stylesheets/admin.css")).to include("*= require jquery-addon")
  end

  it "should require the blogs file in the admin manifest" do
    expect(File.read("app/assets/stylesheets/admin.css")).to include("*= require blogs")
  end
end
