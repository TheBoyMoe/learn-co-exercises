class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true
  validate :check_listing_owner, :check_listing_available, :check_listing_checkout_valid

  def duration
    checkout - checkin
  end

  def total_price
    listing.price * duration
  end

  private
    def check_listing_owner
      if guest_id == listing.host_id
        errors.add(:guest_id, "You can't book your own appartment")
      end
    end

    def check_listing_available
      Reservation.where(listing_id: listing.id).where.not(id: id).each do |r|
        booked_dates = r.checkin..r.checkout
        if booked_dates === checkin || booked_dates === checkout
          errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
        end
      end
    end

    def check_listing_checkout_valid
      # checkout date occurs before checkin
      if checkout && checkin && checkout <= checkin
        errors.add(:guest_id, "Your check-out date needs to be after your check-in.")
      end
    end
end
