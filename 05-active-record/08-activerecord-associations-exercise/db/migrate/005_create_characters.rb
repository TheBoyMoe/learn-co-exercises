class CreateCharacters < ActiveRecord::Migration[4.2]

  def change
    create_table :characters do |t|
      t.string :name
      t.integer :show_id
    end
  end
end
