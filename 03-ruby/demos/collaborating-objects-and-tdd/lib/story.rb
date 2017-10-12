class Story
    attr_accessor :name
    attr_reader :author, :category


    # 'belongs to' interface - story belongs to author
    def author=(author)
        raise AssociationTypeMismatchError, "#{author.class} received, Author Expected" if !author.is_a?(Author)
        @author = author
        author.add_story(self) unless author.stories.include?(self)
    end

    def category=(category)
        raise AssociationTypeMismatchError, "#{category.class} received, Category expected" if !category.is_a?(Category)
        @category = category
        category.add_story(self) unless category.stories.include?(self)
    end

end