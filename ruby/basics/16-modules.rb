=begin
    Modules have a number of uses, as a means of storage, or as a container, but it's most common use is to add nbehaviour to classes
        - you can add the same behaviour to different classes via modules - called using modules as a mixin, since we're mixig in behaviours into a class
    Modules use the same rules as classes when writing them    
        - we use the keyword 'module', followed by the modules name in camel case and the key word 'end'
    Modules allow us to create namespaces, which can be other modules, classes, constants and more.
        - these classes, modules, constants, etc can be accessed using the constant resolution operator(::) 
    Both the Ruby Core (Ruby features) and Std Library (additional programs you can include in your programs) include various modules which you can use
        - Comparable module - mixin that provides a number of convenience classes making yor classes sortable

    References
    [1] http://ruby-doc.org/core-2.2.2/Comparable.html


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