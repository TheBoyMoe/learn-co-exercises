require "rails_helper"

RSpec.describe do
  it "should include the main file in the application layout" do
    expect(File.read("app/views/layouts/application.html.erb")).to match(/stylesheet_link_tag ['"]application['"]/)
  end
end
