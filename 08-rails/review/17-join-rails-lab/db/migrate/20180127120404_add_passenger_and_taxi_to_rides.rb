class AddPassengerAndTaxiToRides < ActiveRecord::Migration
  def change
    add_reference :rides, :passenger, index: true, foreign_key: true
    add_reference :rides, :taxi, index: true, foreign_key: true
  end
end
