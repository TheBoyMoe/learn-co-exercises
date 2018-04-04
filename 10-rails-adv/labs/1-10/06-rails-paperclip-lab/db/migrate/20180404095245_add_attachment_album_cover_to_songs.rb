class AddAttachmentAlbumCoverToSongs < ActiveRecord::Migration
  def self.up
    change_table :songs do |t|
      t.attachment :album_cover
    end
  end

  def self.down
    remove_attachment :songs, :album_cover
  end
end
