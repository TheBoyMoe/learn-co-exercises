class CreateArtists < ActiveRecord::Migration

  # execute when the migration is run
  def up
  end

  # execute when the migration is rolled back, 'undo'
  def down
  end

  # primary method run when executing simple migrations, where Active Recod can reverse the migration automatically
  # this method replaces the .create_table method, id key is automatically created
  def change
    create_table :artists do |c|
      c.string :name
      c.string :genre
      c.integer :age
      c.string :hometown
    end
  end
end
