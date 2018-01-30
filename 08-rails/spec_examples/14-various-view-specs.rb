# review-21/specs
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


# review-22/features/artists_spec.rb
describe "artists", type:  :feature do
	before do
		Artist.destroy_all
		Song.destroy_all
		@artist = Artist.create!(name: "Daft Punk")
		@grid = @artist.songs.create!(title: "The Grid")
		@voyager = @artist.songs.create!(title: "Voyager")
	end

	it "links to the artist's songs by title" do
		visit artist_path(@artist)
		expect(page).to have_link("The Grid", href: song_path(@grid))
	end

	it "lists all of the artist's songs" do
		visit artist_path(@artist)
		within("ul") do
			expect(page).to have_content("The Grid")
			expect(page).to have_content("Voyager")
		end
	end

	it "lists the artists" do
		visit artists_path
		expect(page).to have_content("Daft Punk")
	end

	it "shows the song count for each artist" do
		visit artists_path
		expect(page).to have_content("2 songs")
	end
end


# review-28 spec/features/appointmetns_apc.rb
describe "appointments", type:  :feature do
	before do
		@hawkeye = Doctor.create({name: "Hawkeye Pierce", department: "Surgery"})
		@homer = Patient.create({name: "Homer Simpson", age:38})
		@appointment = Appointment.create({appointment_datetime: DateTime.new(2016, 03, 15, 18, 00, 0), patient: @homer, doctor: @hawkeye})
	end

	it "should display an appointment's doctor" do
		visit appointment_path(@appointment)
		expect(page).to have_link("Hawkeye Pierce", href: doctor_path(@hawkeye))
	end

	it "should display an appointment's patient" do
		visit appointment_path(@appointment)
		expect(page).to have_link("Homer Simpson", href: patient_path(@homer))
	end

	it "should not have an index page" do
		expect {visit('/appointments')}.to raise_error(ActionController::RoutingError)
	end
end
