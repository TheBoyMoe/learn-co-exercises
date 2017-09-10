class CreateHeros < ActiveRecord::Migration[5.1]
  def change
    # hero belongs_to the team, requires the team_id colum
    create_table :heros do |t|
      t.string :name
      t.string :power
      t.string :bio
      t.integer :team_id

      t.timestamps
    end
  end
end
