class Song < ApplicationRecord
  # song belongs to artist (one-to-one association - a song can have one artist),
  # song has the artist_id column in table (foreign key) - belongs_to always means that you need to add a foreign key to the table.
  # adds methods such as #artist, #artist=, #build_artist, #create_artist, called on the song instance
  belongs_to :artist
end
