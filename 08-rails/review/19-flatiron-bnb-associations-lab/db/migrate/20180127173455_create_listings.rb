class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :listing_type
      t.string :title
      t.string :description
      t.decimal :price
      t.references :neighborhood, index: true, foreign_key: true
      t.references :host, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
