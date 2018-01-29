class User < ActiveRecord::Base
  # as host
  has_many :listings, foreign_key: 'host_id'
  has_many :reservations, through: :listings
  has_many :guests, through: :listings, foreign_key: 'host_id'
  has_many :host_reviews, through: :listings, source: :reviews

  # as guest
  has_many :trips, class_name: "Reservation", foreign_key: 'guest_id'
  has_many :reviews, foreign_key: 'guest_id'
  has_many :trip_listings, through: :trips, source: :listing
  has_many :hosts, through: :trip_listings, foreign_key: 'host_id'
end
