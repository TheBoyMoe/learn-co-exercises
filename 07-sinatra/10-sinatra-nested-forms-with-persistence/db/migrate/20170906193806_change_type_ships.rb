class ChangeTypeShips < ActiveRecord::Migration[5.1]
  def change
    rename_column :ships, :type, :category
  end
end
