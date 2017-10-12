class CreateMovies < ActiveRecord::Migration

  def change
    create_table :movies do |c|
      c.string :title
      c.integer :release_date
      c.string :director
      c.string :lead
      c.integer :in_theaters
    end
  end

end
