class CreatePassengersTaxis < ActiveRecord::Migration
  def change
    create_table :passengers_taxis do |t|
      t.references :taxi, index: true, foreign_key: true
      t.references :passenger, index: true, foreign_key: true
    end
  end
end
