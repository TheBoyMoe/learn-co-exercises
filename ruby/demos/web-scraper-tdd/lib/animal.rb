require 'open-uri'
require 'nokogiri'
require_relative './animal_scraper.rb' # req'd if loading file via irb

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
    Animal.new.tap do |animal|
      # fetch data from wiki page - refactored to AnimalScraper class
      # doc = Nokogiri::HTML(open(url))
      # animal.name = doc.search("h1#firstHeading").text
      # animal.kingdom = doc.search(".infobox a[href='/wiki/Animal']").text
      # animal.phylum =	doc.search(".infobox a[title=Chordate]").text
      # animal.klass =	doc.search(".infobox a[title=Mammal]").text
      # animal.order =	doc.search(".infobox a[title^=Even-toed]").text
      # animal.family =	doc.search(".infobox a[title=Hippopotamidae]").text
      # animal.genus =	doc.search(".infobox a[title^=Hippopotamus]").text
      # animal.species = doc.search("span.species").text
      properties = AnimalScraper.wikipedia_scraper(url)
      properties.each do |k, v|
        animal.send("#{k}=", v) # mass assignment
      end
    end
  end

  # constructor - instantiate the obj using different sources
  def self.new_from_file(path)
    Animal.new.tap do |animal|
      # configure animal obj and return
    end
  end

  # finder method, e.g. find an animal by name
  def self.find_by_name(name)
    self.all.detect {|a| a.name == name}
  end

end
