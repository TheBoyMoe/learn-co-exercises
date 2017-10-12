=begin
    References
    [1] http://ruby-doc.org/core-2.0.0/Random.html
    [2] http://ruby-doc.org/core-2.0.0/String.html#method-i-index
    [3] http://ruby-doc.org/core-2.1.3/Regexp.html

=end


# prompt a user to guess a number between 0 and 5
random_number = Random.new.rand(5)
loop do
    print "Guess the number between 0 and 5 (e to exit): "
    answer = gets.chomp
    if answer == 'e'
        puts 'Goodbye!'
        break
    else
        if answer.to_i == random_number
            puts "You guessed correctly!"
            break
        else
            puts 'Try again'    
        end
    end
end