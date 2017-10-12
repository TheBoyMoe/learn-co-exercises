class Song
  attr_accessor :name, :artist, :genre

  def initialize(name, genre)
    @name = name
    @genre = genre
    genre.add_song(self)
  end
end

class Genre
  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    self.songs << song
  end

  # iterate over the genre's songs 'collecting' the artists
  # example of 'has many through' relationship - the genre has many artists through songs
  def artists
    self.songs.collect {|s| s.artist}
  end
end


class Artist
  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  # This is the "has many"/"belongs to" association. A song belongs to an artist and an artist has many songs
  def add_song(song)
      self.songs << song #=> 'has many'
      song.artist = self #=> 'belongs to'
  end

  # iterate over the songs in order to 'collect' the genres
  # example of 'has many through' relationship - the artist has many genres through songs
  def genres
    self.songs.collect {|s| s.genre}
  end
end


# examples
jay_z = Artist.new("Jay-Z")

rap = Genre.new("rap")
pop = Genre.new("pop")

ninety_nine_problems = Song.new("99 Problems", rap)
crazy_in_love = Song.new("Crazy in Love", pop)
lucifer = Song.new("Lucifer", rap)

jay_z.add_song(ninety_nine_problems)
jay_z.add_song(crazy_in_love)
jay_z.add_song(lucifer)

jay_z.genres
  # => [rap, pop]
rap.songs
  # => [ninety_nine_problems, lucifer]
