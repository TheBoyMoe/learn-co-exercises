require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  before {Author.create(name: 'Peter Jones')}

  describe "GET #show" do
    it "returns http success" do
      visit author_path(Author.find_by(id: 1))
      expect(response).to have_http_status(:success)
    end
  end

end
