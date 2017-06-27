=begin
    Modules have a number of uses, as a means of storage, or as a container, but it's most common use is to add nbehaviour to classes
        - you can add the same behaviour to different classes via modules - called using modules as a mixin, since we're mixig in behaviours into a class
    Modules use the same rules as classes when writing them    
        - we use the keyword 'module', followed by the modules name in camel case and the key word 'end'
    Modules allow us to create namespaces, which can be other modules, classes, constants and more.
        - these classes, modules, constants, etc can be accessed using the constant resolution operator(::) 
    Both the Ruby Core (Ruby features) and Std Library (additional programs you can include in your programs) include various modules which you can use
        - Comparable module - mixin that provides a number of convenience classes making yor classes sortable
        - Math module - provides sin, log, tangent, etc functionality. Math methods are not applied to instances of the classes we create, instead the methods are called on the Math class itself.
        - Enumerable module - since enumerable is a module we can include it in our own classes and get access to some of the same methods available to arrays and hashes, e.g any?, all?, include?
            - any class that includes Enumerable MUST implement the each method, allowing ruby to iterate over successive members of the collection.
            - the class must also implement a <=> comparable method if you intend to use the sort, min or max methods, since these methods rely i=on ordering of members
    Mixins 
        - if we want to include a mixin with our class we use the 'include' keyword. Gives our class access to all methods within the mixin
        - we can add the 'included' method in our modules. included is a class method
        - the included method allows us to write methods and include other modules which are then accessible to any class that includes our module
        - included runs automatically, it takes one argument - the class of the obj the module is included in, generally written as 'klass' since 'class' is a reserved word
        - we can use included to add class propertiesand methods to the classes the module is included with

    References
    [1] http://ruby-doc.org/core-2.2.2/Comparable.html
    [2] http://ruby-doc.org/core-2.2.2/Math.html
    [3] http://ruby-doc.org/core-2.2.2/Enumerable.html

=end

module LaserBots

    VERSION = 1.01

    module Console
        class Command

        end
    end
    
    module World

        # By including the Comparable class and defining the spaceship 
        # operator( <=> ) enables the comparison of the obj against 
        # different instances of the class, returning -1,0 or 1 depending
        # on wether the receiver is less than, equal to or greater the other instance
        class Player
            # makes the methods of the Comparable module available
            include Comparable 

            attr_reader :name, :score

            def <=>(other_player)
                score <=> other_player.score
            end

            def initialize(name, score)
                @name = name
                @score = score
            end    
        end
        
        class Robot
            attr_reader :name
            def initialize(name)
                @name = name
            end 
        end
    end
      
end

# accessing nested namespaces
version = LaserBots::VERSION
dave = LaserBots::World::Player.new('Dave', 100)
frank = LaserBots::World::Player.new('Frank', 90)
hal = LaserBots::World::Robot.new('Hal9000')

puts "dave > frank: %s" % (dave > frank)
puts "dave < frank: %s" % (dave < frank)

# player1 = Player.new('Simon', 23)
# player2 = Player.new('Alfred', 54)


#### Math Module #####

puts Math::E          # => 2.718281828459045
puts Math::PI         # => 3.141592653589793
puts Math.sqrt(9)     # => 3.0
puts Math.cos(1)      # => 0.5403023058681398
puts Math.hypot(2, 2) # => 2.8284271247461903
puts Math.log(2, 10)  # => 0.30102999566398114
puts Math.log(2, 12)  # => 0.2789429456511298


#### Adding Mixin Behaviour to our Classes ####

module Fetcher
    def self.included(klass)
        # puts "#{klass} has been included"
        # every class gets the fatch_count property
        attr_accessor :fetch_count
    end

    def fetch(item)
        @fetch_count ||= 0
        @fetch_count += 1
        puts "#{@name}, fetch count: #{@fetch_count}. I'll bring that #{item} right back"
    end

    def hungary
        puts "Tired of playing, I'm hungry, let's get a taco!"
    end

end


class Dog
    include Fetcher
    attr_reader :name

    def initialize(name)
        @name = name
    end
end

fido = Dog.new('Fido')
fido.fetch('stick')
fido.fetch('ball')
fido.fetch('toy')
fido.hungary