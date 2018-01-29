class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, :description, presence: true

  validate :check_reservation_status, :checkout_has_happened

  def check_reservation_status
    if reservation.try(:status) != 'accepted'
      errors.add(:reservation, "The reservation must be accepted to leave a review")
    end
  end

  def checkout_has_happened
    if reservation && reservation.checkout > Date.today
      errors.add(:reservation, "Reservation must have ended to leave a review")
    end
  end
end
