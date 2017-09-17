module Concerns
  module Slugifiable

    module InstanceMethods
      def slug
        # return a slugified version of the artist/genre/song name
        # replace ' ' with '-'
        self.name.gsub(' ', '-').downcase
      end
    end

    module ClassMethods
      def find_by_slug(slug)
        # use the slug method to retrieve song/artist/genre from the database
        self.all.find do |instance|
          instance.slug == slug
        end
      end
    end

  end
end
