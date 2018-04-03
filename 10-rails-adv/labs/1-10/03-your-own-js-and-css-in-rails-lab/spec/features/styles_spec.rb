require 'rails_helper'

feature "Page Styles" do
  scenario "'Click To Hide Me' link has error CSS class" do
    visit '/'
    expect(page).to have_css("a.error", text: "Click To Hide Me")
  end

  scenario "body tag has cool-background CSS class" do
    visit '/'
    expect(page).to have_css("body.cool-background")
  end
end
