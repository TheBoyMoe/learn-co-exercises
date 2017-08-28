class Artist < ApplicationRecord
  # one-to-many relationship
  # avoid using the << method to add a song to the songs collection.
  # innificient since it returns all the collection with all the other records
  has_many :songs
end
