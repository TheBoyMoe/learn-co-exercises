require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do

  describe "github_search" do

    it "makes a request to github" do
      stubbed_request = stub_request(:get, "https://api.github.com/search/repositories").with(query: hash_including({q: "tetris"})).to_return(body: repository_response)
      post 'github_search', query: "tetris"
      expect(stubbed_request).to have_been_requested
      expect(response).to render_template('search')
    end
  end
end
