require 'rails_helper'

RSpec.describe SongsController do
  before do
    Song.destroy_all
    Artist.destroy_all
    100.times do
      Song.create(title: Faker::Lorem.word)
    end
  end

  describe "GET /index" do
    it 'pages 20 per page' do
      get :index
      expect(assigns[:songs].count).to eq 20
      songs1 = assigns[:songs]
      get :index, page: 2
      expect(assigns[:songs]).to_not eq songs1
    end
  end
end
