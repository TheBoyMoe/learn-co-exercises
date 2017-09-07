class ChangePirateIdShips < ActiveRecord::Migration[5.1]
  def change
    rename_column :ships, :pitate_id, :pirate_id
  end
end
