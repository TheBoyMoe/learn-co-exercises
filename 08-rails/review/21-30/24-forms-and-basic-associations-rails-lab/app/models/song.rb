class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name
    self.genre.name if self.genre
  end

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def artist_name
    self.artist.name if self.artist
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  # return the contents of each note as an array
  def note_contents
    self.notes.map(&:content) if self.notes
  end

  # add each note to the song instance if it has not already
  def note_contents=(notes)
    notes.each do |content|
      if content && !content.empty?
        note = Note.find_or_create_by(content: content)
        unless self.notes.include? note
          self.notes << note
        end
      end
    end
  end

end

