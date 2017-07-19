
class Author
    attr_accessor :name

    def initialize
       @stories = [] 
    end

    def stories
        # return a frozen duplicate of soties, only way to add a story instance is through #add_story
        @stories.dup.freeze
    end

    # has many interface
    def add_story(story)
        raise AssociationTypeMismatchError, "#{story.class} received, Story expected" if !story.is_a?(Story)
        @stories << story
        story.author = self unless story.author == self
    end

    def bibliography
        self.stories.collect {|story| story.name}
    end

end
