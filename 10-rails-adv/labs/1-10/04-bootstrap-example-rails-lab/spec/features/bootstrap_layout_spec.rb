require 'rails_helper'

feature "Bootstrap Layout" do
  before :each do
    visit '/'
  end

  context 'Grid' do
    scenario "Page has a container" do
      expect(page).to have_css("div.container")
    end

    scenario "Page has 3 rows" do
      expect(page).to have_selector('div.row', count: 3)
    end

    scenario "Each row has 3 col-lg-4" do
      expect(page).to have_selector('div.col-lg-4', count: 9)
    end
  end

  context 'Content' do
    scenario "Each col-lg-4 has <p> and bootstrap button" do
      expect(page).to have_selector('div.row div.col-lg-4 p', count: 9)
      expect(page).to have_selector('div.row div.col-lg-4 .btn', count: 9)
    end
  end

  context 'Navigation' do
    scenario "Page has a navbar" do
      expect(page).to have_css("ul.nav.navbar-nav")
    end

    scenario "Navbar has 3 links: Home, About, Contact" do
      expect(page).to have_css("ul.nav.navbar-nav li", text: "Home")
      expect(page).to have_css("ul.nav.navbar-nav li", text: "About")
      expect(page).to have_css("ul.nav.navbar-nav li", text: "Contact")
    end
  end
end
