class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references :user, index: true
      t.references :attraction, index: true
    end
    add_foreign_key :rides, :users
    add_foreign_key :rides, :attractions
  end
end
