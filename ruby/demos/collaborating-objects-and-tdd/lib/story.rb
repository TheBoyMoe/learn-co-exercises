class Story
    attr_accessor :name
    attr_reader :author

    # 'belongs to' interface - story belongs to author
    def author=(author)
        raise AssociationTypeMismatchError, "#{author.class} received, Author Expected" if !author.is_a?(Author)
        @author = author
        author.add_story(self)
    end

end