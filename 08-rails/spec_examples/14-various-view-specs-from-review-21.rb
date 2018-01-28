RSpec.describe "posts/show", type: :feature do
	before {
		visit post_path(@post)
	}

	it "shows the post's title in an <h1> tag" do
		expect(page).to have_css("h1", text: "My Post")
	end

	it "shows the post's description in a <p> tag" do
		expect(page).to have_css("p", text: "My post desc")
	end

	it "contains a link to the post's category" do
		expect(page).to have_link(@category.name, href: category_path(@category))
	end
end


RSpec.describe "posts/edit", type: :feature do
	it 'shows an update form that submits content, redirects, and shows the updated content' do
		visit edit_post_path(@post)

		fill_in 'post[title]', with: "My Edited Post"
		fill_in 'post[description]', with: "My edited post description"

		click_on "Update Post"

		expect(current_path).to eq(post_path(@post))
		expect(page).to have_content("My Edited Post")
		expect(page).to have_content("My edited post description")
	end
end


RSpec.describe "categories/show", type: :feature do
	before {
		visit category_path(@category)
	}

	it 'shows the category name on the show page in an <h1> tag' do
		expect(page).to have_css("h1", text: "My Category")
	end

	it "contains links to the category's posts" do
		expect(page).to have_link(@post.title, href: post_path(@post))
	end
end


RSpec.describe "categories/edit", type: :feature do
	it 'shows an update form that submits content, redirects, and shows the updated content' do
		visit edit_category_path(@category)
		fill_in 'category[name]', with: "My Edited Category"
		click_on "Update Category"

		expect(current_path).to eq(category_path(@category))
		expect(page).to have_content("My Edited Category")
	end
end