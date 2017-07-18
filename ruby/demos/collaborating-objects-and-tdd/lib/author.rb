require 'pry'
require_relative './story.rb'

class Author
    attr_accessor :name
    attr_reader :stories

    def initialize
       @stories = [] 
    end

    def add_story(story)
        raise AssociationTypeMismatchError if !story.is_a?(Story)
        self.stories << story
    end

end

# binding.pry