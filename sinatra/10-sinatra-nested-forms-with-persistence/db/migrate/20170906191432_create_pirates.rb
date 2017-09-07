class CreatePirates < ActiveRecord::Migration[5.1]
  def change
    # pirate has_many ships - no reference req'd for ship since it's the parent class
    create_table :pirates do |t|
      t.string :name
      t.string :weight
      t.string :height
      t.timestamps
    end
  end
end
