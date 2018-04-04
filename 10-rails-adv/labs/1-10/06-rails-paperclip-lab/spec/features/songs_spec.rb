require 'rails_helper'

describe "songs", type:  :feature do

  before do
    Artist.destroy_all
    Song.destroy_all
    @artist = Artist.create!(name: "Daft Punk")
    @song = @artist.songs.create!(title: "The Grid")
  end

  describe "/songs/new" do
    it "can attach an album cover and display it" do
      visit new_song_path
      fill_in "Title", with: "Birdhouse In Your Soul"
      fill_in "song_artist_name", with: "TMBG"
      attach_file "song_album_cover", Rails.root.join('spec', 'support', 'homer.gif')
      click_button "Create Song"

      expect(page).to have_css("img[src*='homer.gif']")
    end
  end

  describe "/songs/:id" do

    it "links to the artist" do
      visit song_path(@song)
      expect(page).to have_link("Daft Punk", href: artist_path(@artist))
    end

    it "links to edit when no artist" do
      song = Song.create(title: "Policy of Truth")
      visit song_path(song)
      expect(page).to have_link("Add Artist", href: edit_song_path(song))
    end

  end

  describe "/songs" do

    it "links to the song" do
      visit songs_path
      expect(page).to have_link("The Grid", href: song_path(@song))
    end

    it "has a link to edit the song if no artist" do
      song = Song.create(title: "Mambo No. 5")
      visit songs_path
      expect(page).to have_link("Add Artist", href: edit_song_path(song))
    end

  end
end
