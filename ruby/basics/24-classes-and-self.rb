class Dog
    attr_accessor :name, :breeed, :owner

    def initialize(name, breed)
        @name = name
        @breed = breed
    end

    def adopted(owner)
        # either works
        # self.owner = owner
        @owner = owner
    end

    def to_s
        puts "My name is #{@name}, I'm a #{@breed}"
    end
end

class Owner
    attr_reader :name
    def initialize(name)
        @name = name
    end
end