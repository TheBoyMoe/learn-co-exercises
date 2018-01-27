class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, through: :neighborhoods
  has_many :reservations, through: :listings

  def city_openings(start_date, end_date)
    openings = []
    self.listings.each do |listing|
      if listing.reservations.none? { |r| (start_date.to_date <= r.checkout && start_date.to_date >= r.checkin) || (end_date.to_date <= r.checkout && end_date.to_date >= r.checkin)}
        openings << listing
      end
    end
    openings
  end

  # city with the highest reservations to listings
  def self.highest_ratio_res_to_listings
    self.has_listings.max_by {|location| location.reservations.count / location.listings.count}
  end

  # city with the most reservations
  def self.most_res
    self.has_listings.max_by {|location| location.reservations.count}
  end

  private
    def self.has_listings
      self.all.select {|location| location.listings.any?}
    end
end

