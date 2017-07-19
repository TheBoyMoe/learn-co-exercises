class Story
    attr_accessor :name
    attr_reader :author

    def author=(author)
        raise AssociationTypeMismatchError, "#{author.class} received, Author Expected" if !author.is_a?(Author)
        @author = author
    end

end