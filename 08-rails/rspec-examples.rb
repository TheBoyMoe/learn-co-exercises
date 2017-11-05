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
