=begin
    - At its most basic, a block is statements of code that are grouped together. The statements can be grouped inside of curly braces or between the do and end keywords.
    - Blocks must use the implicit return format in Ruby.
        - you can't use the return statement
        - use the implicit return, e.g. the return value of the last line of the block
    - Multi line blocks are usually written using the do and end format
    - Single line blocks are usually written using curly braces {}.
    
    You can write methods that take a block, the block is considered an argument to the method
        - to get the method to execute the block you use the 'yield' keyword
        - tells ruby to leave the method run the code in the block and return to the point it was called
        - adding a 2nd (or more) yield keyword causes the block to be executed again.

    Block can take arguments like methods
        - the args are sent into the block, use pipes and the argument that you want to access inside of the block
        - pass the argument following the call to yield
        - the argument passed into the block is only accessible inside the block, outside you get the undefined local variable error

        - we can also assign the block to a variable, e.g,&block, and then call it in the method using block.call(), and passing the arg to the block via call()
        - if the block does not take an argument, call block.call
        - you can pass in multiple arg to the block using this pattern, e.g, block.call(name, age)
=end

# define a method
def block_method
    puts "This is the first line in block method"
    yield
    # yield
    puts "This line was executed after the block"
end

# call the method and pass in the block
block_method do
    puts "\tThis statement is called from the block"
end

# pass arguments to blocks
[1,2,3,4,5,6].each do |value|
    puts "Value #{value}"
end    

[1,2,3,4,5,6].each {|value| puts "Value #{value}"}

def get_name
    print "Enter your name: "
    name = gets.chomp
    yield name
end

get_name do |my_name|
    puts "That's a cool name, #{my_name}"
end

# Methods that take blocks can return values normally:
def get_name
  print "Enter your name: "
  name = gets.chomp
  yield name
  name # return this value after the block has returned
end

my_name = get_name do |your_name|
  puts "That's a cool name, #{your_name}!"
end

puts "My name: #{my_name}"

# you can send in multiple args to a block
def get_name
  print "Enter your name: "
  name = gets.chomp
  print "How old are you: "
  age = gets.chomp
  yield name, age
end

get_name do |your_name, your_age|
  puts "That's a cool name, #{your_name}, #{your_age} years old!"
end

# pass an argument to our method
def get_name(prompt)
  print "#{prompt}: "
  name = gets.chomp
  print "How old are you: "
  age = gets.chomp
  yield name, age
end

get_name("Enter your name") do |your_name, your_age|
  puts "That's a cool name, #{your_name}, #{your_age} years old!"
end

# calling the block by assigning it to a variable
def get_name(prompt, &block)
  print "#{prompt}: "
  name = gets.chomp
  print "How old are you: "
  age = gets.chomp
  block.call(name, age)
end

get_name("Enter your name") do |your_name, your_age|
  puts "That's a cool name, #{your_name}, #{your_age} years old!"
end

# execute the block if it's given
def get_name(prompt, &block)
  print "#{prompt}: "
  name = gets.chomp
  block.call(name) if block_given?
  # yield name if block_given? # either works
end

get_name("This is the last one")

# get_name("Enter your name") do |your_name|
#   puts "Woooooo That's a cool name, #{your_name}!"
# end