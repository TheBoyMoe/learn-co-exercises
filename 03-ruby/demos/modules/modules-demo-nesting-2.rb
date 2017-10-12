require 'pry'

=begin
modules can not be instantiated, they no notheing of instances or ClassMethods calling modules Instance/ClassMethods has no bearing on whether the methods are class or instance methods the use of the 'extend' abd 'include' keywords determine whethre the methods are class or instance methods and 'self' is the instance or class - extend == class, include == instance

mixing in (include) and extnding classes with modules is refered to as the
Mixin/Builder/Module Pattern

Order of method lookup
1. the object itself
2. the class
3. any specified modules
4. any parent classes of the objet (any super classes)
=end

module Memorable
  module InstanceMethods
    def initialize(name)
      @name = name
      self.class.all << self
    end
    def tester
      puts "called from the module InstanceMethods"
    end
  end

  module ClassMethods
    def reset_all
      self.all.clear
    end

    def count
      self.all.count
    end

    def tester
      puts "called from the module ClassMethods"
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

  def tester
    puts "called from the instance"
  end

  def self.tester
    puts "called from the class"
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
