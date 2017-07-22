require 'open-uri'
require 'nokogiri'

class Animal
  attr_accessor :name, :kingdom, :phylum, :klass, :order, :family, :genus, :species
  @@all = []

  def initialize
    self.class.all << self
  end

  def self.all
    @@all
  end

  # constructor
  def self.new_from_wikipedia(url)
    animal = Animal.new
    # fetch data from wiki page
    doc = Nokogiri::HTML(open(url))
    animal.name = doc.search("h1#firstHeading").text
    animal.kingdom = doc.search(".infobox a[href='/wiki/Animal']").text
    animal.phylum =	doc.search(".infobox a[title=Chordate]").text
    animal.klass =	doc.search(".infobox a[title=Mammal]").text
    animal.order =	doc.search(".infobox a[title^=Even-toed]").text
    animal.family =	doc.search(".infobox a[title=Hippopotamidae]").text
    animal.genus =	doc.search(".infobox a[title^=Hippopotamus]").text
    animal.species = doc.search("span.species").text

    animal
  end

end
