class Song
    attr_accessor :title, :artist

    def self.new_by_filename(filename)
        song = self.new
        song.title = filename.split(' - ')
        song
    end
    
    # if a song does not have an artist object associated with it, create one
    def artist_name=(name)
        if self.artist.nil?
            self.artist = Artist.new(name)
        else
            self.artist.name = name
        end    
    end

end


class MP3Importer
    
    def import(list_of_filenames)
        list_of_filenames.each do |filename|
            Song.new_by_filename(filename)
        end
    end
end


class Artist
    attr_accessor :name

    def initialize(name)
        @name = name
    end
end

