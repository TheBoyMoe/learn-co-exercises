### Blocks and Mehods ###

# simple method with a block
def block_method
    puts "This is called from the method"
    yield
    puts "This is also called from the method"
end

block_method do
    puts "This was called from the block"
end

#### passing values to blocks from methods

def my_counter
    puts yield 10
end

my_counter do |num|
    num * 10
end
#=> 100


#### example 2

def my_2nd_counter(num)
    val = yield num * 2
    puts "Calculated value #{val}"
end

my_2nd_counter(5) do |num|
    num * 10
end

#=> 'Calculated value 100'

### Example 3

def get_value(prompt)
    print prompt + ': '
    value = gets.chomp.to_i
    yield value
end

value = get_value('Pick a number between 5 and 10') do |val|
    "You picked the number #{val}"
end

puts value


### Assigning the block to a variable & passing in multiple args (avoids use of yield)

def get_name(prompt, &block)
    print prompt + ': '
    name = gets.chomp
    print 'What do you do?: '
    job = gets.chomp
    block.call(name, job)
end

name = get_name("Enter your name") do |n, j|
    "Hi #{n}. #{j}, that's a cool job!"
end

puts name

### Make the block optional

def get_age(prompt)
    print prompt + ': '
    age = gets.chomp
    yield age if block_given?
    age
end

age = get_age("How old are you?") do |val|
    puts "#{val}, you're kidding me, right!!"
end

puts age


def get_name2(prompt, &block)
    print prompt + ': '
    name = gets.chomp
    print 'What do you do?: '
    job = gets.chomp
    block.call(name, job) if block_given? # returns nothing
end

name = get_name2("Enter your name") 

puts name # prints nothing