class AddFavoriteFoodToArtists < ActiveRecord::Migration

  # alter the database
  # to the 'artists' table, add the 'favorite_food' column of datatype 'string'
  def change
    add_column :artists, :favorite_food, :string
  end
end
