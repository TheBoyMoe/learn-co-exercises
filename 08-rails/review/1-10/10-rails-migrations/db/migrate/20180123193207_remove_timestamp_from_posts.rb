class RemoveTimestampFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :timestamp, :string
  end
end
