class AddContentToPosts < ActiveRecord::Migration[4.2]

  def change
    add_column :posts, :content, :text
  end
end
