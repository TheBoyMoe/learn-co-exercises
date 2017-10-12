class CreateShips < ActiveRecord::Migration[5.1]
  def change
    # ship belongs_to pirate, requires pirate_id column
    create_table :ships do |t|
      t.string :name
      t.string :type
      t.string :booty
      t.integer :pitate_id
      t.timestamps
    end
  end
end
