### Classes ####

# basic class creation
class Name
    def initialize(title, first, middle, last)
        @title = title # instance variable accessible throughout the instance
        @first = first
        @middle = middle
        @last = last
    end

    def info
        info = "#{@title} #{@first} #{@middle} #{@last}" # local variable, avalable within the method
        puts info
    end
end

tom = Name.new('Sr.', 'Tom', '', 'Jones')
tom.info


# example 2
class FullName
    def initialize(title, first, middle, last)
        @title = title
        @first = first
        @middle = middle
        @last = last
    end

    def title
        @title
    end

    def first
        @first
    end

    def middle
        @middle
    end

    def last
        @last
    end

    def info
        puts "#{title} #{first} #{middle} #{last}" # call the methods to fetch the variables
    end
end

john = FullName.new('Mr', 'John', 'Paul', 'Jones') 
john.info

# example 3
class CompleteName
    attr_reader :title, :first, :middle, :last # getters
    def initialize(title, first, middle, last)
        @title = title
        @first = first
        @middle = middle
        @last = last
    end

    # setters
    def title=(title)
        @title = title
    end

    def first=(first)
        @first = first
    end

    def last=(last)
        @last = last
    end

    def info
        puts "#{title} #{first} #{middle} #{last}" # uses the attr_reader to fetch the variables
    end
end

grace = CompleteName.new('Ms.', 'Grace', '', 'Jones')
grace.info
grace.title = 'Mrs.'
grace.last = 'Smith'

# example 4
class CompleteName2
    # get & set instance variables, better yet use 'attr_accessor'
    attr_reader :title, :first, :middle, :last
    attr_writer :title, :first, :middle, :last
    def initialize(title, first, middle, last)
        @title = title
        @first = first
        @middle = middle
        @last = last
    end

    def to_s
        puts "#{title} #{first} #{middle} #{last}"
    end
end


# example 5
class CompleteNameFinal
    # get & set instance variables
    attr_accessor :title, :first, :middle, :last

    def initialize(title, first, middle, last)
        @title = title
        @first = first
        @middle = middle
        @last = last
    end

    def to_s
        puts "#{title} #{first} #{middle} #{last}"
    end
end
