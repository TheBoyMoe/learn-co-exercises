# example of createing a model instance within a spec
# note REQUIRES - Factory Girl/Bot gem
# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
describe "POST create" do
    context "with valid attributes" do
      it "creates a new student" do
        expect{
          post :create, { :first_name => "Sam", :last_name => "Smith" }
        }.to change(Student,:count).by(1)
      end

      it "redirects to the new student" do
        post :create, { :first_name => "Sam", :last_name => "Smith" }
        expect(response).to redirect_to Student.last
      end
    end
  end


# test for a link
describe 'linking from the index page to the show page' do
  it 'index page links to post page' do
    @student = Student.create!(first_name: "Daenerys", last_name: "Targaryen")
    visit students_path
    expect(page).to have_link(@student.to_s, href: student_path(@student))
  end
end

# example of using have_content
describe 'Multiple coupons are shown' do
  it 'on the index page' do
    Coupon.create(coupon_code: "ASD123", store: "Chipotle")
    Coupon.create(coupon_code: "XYZ098", store: "Jamba")
    visit coupons_path
    expect(page).to have_content(/Chipotle|Jamba/)
  end
end


### Form_for tag & testing

=begin
<%= form_for(@school_class) do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <%= f.label :room_number %>
  <%= f.text_field :room_number %>
  <%= f.submit %>
<% end %>
=end

it 'new form submits content and renders form content' do
  visit new_school_class_path

  fill_in 'school_class_title', with: "Software Engineering"
  fill_in 'school_class_room_number', with: 10

  click_on "Create School class"

  expect(page).to have_content("Software Engineering")
end
