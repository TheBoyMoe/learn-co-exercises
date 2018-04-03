require "rails_helper"

RSpec.describe do
  it "should include the main file in the admin layout" do
    expect(File.read("app/views/layouts/admin.html.erb")).to match(/stylesheet_link_tag ['"]admin['"]/)
  end

  it "should include the remaining CSS file (posts.css) in the admin layout" do
    expect(File.read("app/views/layouts/admin.html.erb")).to match(/stylesheet_link_tag ['"]posts['"]/)
  end
end
