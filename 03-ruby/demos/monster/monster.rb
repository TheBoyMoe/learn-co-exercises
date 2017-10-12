class Monster
    attr_reader :name, :actions
    def initialize(name)
        @name = name
        @actions = {scream: 0, scares: 0, run: 0, hide: 0}
    end

    def say(&block)
        print "#{name} says... "
        block.call
    end

    def scream(&block)
        actions[:scream] += 1
        print "#{name} screams "
        block.call
    end

    def scares(&block)
        actions[:scares] += 1
        print "#{name} scares you "
        block.call
    end

    def run(&block)
        actions[:run] += 1
        print "#{name} runs after you. "
        block.call
    end

    def hide(&block)
        actions[:hide] += 1
        print "#{name} hides. "
        # block.call
        # you can pass the instance of the monstar to the yield
        yield self if block_given?
    end

    def print_scoreboard
       puts "-" * 20
       puts "#{name}'s\tscoreboard"
       puts "-" * 20
       puts "screams:\t#{actions[:scream]}"
       puts "scares:\t\t#{actions[:scares]}"
       puts "hides:\t\t#{actions[:hide]}"
       puts "runs:\t\t#{actions[:run]}"
       puts "-" * 20
    end
end

monster = Monster.new('Ogre')
monster.say do
    puts "FI FY FOE THUMB...... "
end
monster.scream do
    puts "AAAAARRRRRGGGHHH!!!"
end

monster.scares { puts "GOOOO AWAY!"}

monster.hide do |monster|
    puts "You SCARED him!!!!"
    # do somethinfg with self
end

monster.run {puts "I'M COMING TO GET YOU!"}
puts monster.print_scoreboard