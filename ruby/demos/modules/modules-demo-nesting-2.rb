require 'pry'

module Memorable
  module InstanceMethods
    def initialize(name)
      @name = name
      self.class.all << self
    end
  end

  module ClassMethods
    def reset_all
      self.all.clear
    end

    def count
      self.all.count
    end
  end

end

module Findable
  module ClassMethods
    def find_by_name(name)
      self.all.detect{|a| a.name == name}
    end
  end
end

module Paramable
  module InstanceMethods
    def to_param
      name.downcase.gsub(' ', '-')
    end
  end
end

class Artist
  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  include Paramable::InstanceMethods
  include Memorable::InstanceMethods
  attr_accessor :name
  attr_reader :songs

  @@artists = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def self.all
    @@artists
  end

  def add_song(song)
    self.songs << song
    song.artist = self
  end

  def add_songs(songs)
    self.songs.each { |song| add_song(song) }
  end

end


class Song
  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  include Paramable::InstanceMethods
  include Memorable::InstanceMethods
  attr_accessor :name
  attr_reader :artist

  @@songs = []

  def initialize(name)
    super(name)
  end

  def artist=(artist)
    @artist = artist
  end

  def self.all
    @@songs
  end
end


binding.pry
