require 'pry'
require_relative './story.rb'

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
        raise AssociationTypeMismatchError if !story.is_a?(Story)
        @stories << story
    end

    def bibliography
        self.stories.collect {|story| story.name}
    end

end

# binding.pry