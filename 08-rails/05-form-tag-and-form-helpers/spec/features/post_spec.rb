require 'rails_helper'

describe 'new post' do
  it "ensures that the form route works with the /new action" do
    visit new_post_path
    expect(page.status_code).to eq(200)
  end

  it "renders HTML in the '/new' template" do
    visit new_post_path
    expect(page).to have_content('Post Form')
  end

  it "displays a new post form that redirects to the index page, which then contains the submitted post's title and description" do
    visit new_post_path
    fill_in 'post_title', with: 'Leverage agile frameworks'
    fill_in 'post_description',  with: 'Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.'
    click_on 'Submit Post'

    expect(page.current_path).to eq(posts_path) # index page
    expect(page).to have_content('Leverage agile frameworks')
    expect(page).to have_content('Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition.')
  end
end
