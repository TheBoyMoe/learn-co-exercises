class Player
    include Comparable
    attr_accessor :name, :score

    def <=>(other_player)
        score <=> other_player.score
    end

    def initialize(name, score)
        @name = name
        @score = score
    end
end

class Game
    include Enumerable
    attr_accessor :players

    def each(&block)
        players.each(&block)
    end

    def initialize
        @players = []
    end

    def add_player(player)
        players.push(player)
    end

    def score
        score = 0
        players.each do |player|
            score += player.score
        end
        score
    end
end

# create some players and games
player1 = Player.new("Jason", 100)
player2 = Player.new("Kenneth", 80)
player3 = Player.new("Nick", 95)
player4 = Player.new("Craig", 20)

game1 = Game.new
game1.add_player(player1)
game1.add_player(player2)

game2 = Game.new
game2.add_player(player3)
game2.add_player(player4)

# Since the Game class include the Enumerable module, we can define the each 
# method in the game class and iterate through players on the game instance
game1.each do |player|
    puts "Player: #{player.name}, score: #{player.score}"
end

# We can also apply the select, any? and find methods to the game instance
high_scores = game1.select do |player|
    player.score > 80
end
puts high_scores.inspect

# determine if any score is over 80
puts game1.any?{|player| player.score > 80}

# return all players with a score > 80
players = game1.find{|player| player.score > 80}
puts "Players with a score > 80", players.inspect