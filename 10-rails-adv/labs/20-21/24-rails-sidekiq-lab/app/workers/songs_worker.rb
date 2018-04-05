class SongsWorker
  include Sidekiq::Worker
  require 'csv'

  def perform(songs_file)
    CSV.foreach(songs_file, headers: true) do |song|
      Song.create(title: song[0], artist_name: song[1])
    end
  end
end
