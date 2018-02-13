class Song < ActiveRecord::Base
  belongs_to :artist

  def artist_name
    artist.name unless artist == nil
  end

  # assign an artist tot he song
  def artist_name=(name)
    unless !name || name.empty?
      artist = Artist.find_or_create_by(name: name)
      self.artist = artist
      save
    end
  end
end
