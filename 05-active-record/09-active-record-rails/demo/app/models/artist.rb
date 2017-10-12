class Artist < ApplicationRecord
  # one-to-many relationship
  # avoid using the << method to add a song to the songs collection.
  # inificient since it returns all the collection with all the other records
  has_many :songs

  validates :name, :presence => true
  validates :name, :length => {:minimum => 5}
end
