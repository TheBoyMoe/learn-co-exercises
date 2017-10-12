=begin
    References:
    [1] http://ruby-doc.org/core-2.2.2/Kernel.html
    [2] http://ruby-doc.org/core-2.2.2/Object.html
    [3] http://ruby-doc.org/core-2.4.1/
    [4] http://ruby-doc.org/stdlib-2.4.1/
    [5] http://ruby-doc.org/core-2.2.2/Marshal.html
    [6] http://ruby-doc.org/core-2.2.2/File.html
    [7] http://ruby-doc.org/core-2.2.2/IO.html
=end


### Structs ####

# std class
class Customer
    attr_accessor :name, :email
    def initialize(name, email)
        @name, @email = name, email
    end
end

# Same class as a struct, a struct is a shortcut to creating a class with accessor methods
# meant to be used as a convienence class when you have a class with just a few attributes
Customer = Struct.new(:name, :email) do
  def name_with_email
    "#{name} <#{email}>"
  end
end

# create a new instance and iterate through the attributes, each of the attributes is passed to each as a block
customer = Customer.new("John", "john@example.com")
customer.each_pair do |name, value|
  puts "#{name} - #{value}"
end


### Object and Kernel ####

=begin
    Object and Kernel classes are the root of all Ruby class and object functionality.
        - Object is the base class that all Ruby classes inherit from. 
        - The Kernel module is included by the Object class and contains methods that can be used in all classes.
=end

# useful kernel methods
block_given?
puts
print
printf
loop
# chomp
# gets
# require

#useful object methods
# methods
# respond_to


### File IO ###

# File class handles all the low level aspects of reading/writeing to disc, so you don't have to
# In 'w' mode, the file is simply overwritten. To append to a current file select the 'a+' rite mode
# Methods of the File class allow you to change the files ownership, when it was created, find out it's size, path, etc 
File.open("example.txt", "w") do |file|
    print "Enter your name: "
    name = gets.chomp
    file.puts "Name: #{name}"
    print "Enter your email: "
    email = gets.chomp
    file.puts "Email: #{email}"
end


### Marshall Class ###

# Convert ruby objects to a byte stream (which can be saved to disc as a string) and back again - allow's you to save the app's state.

class Player
    attr_accessor :name, :progress

    def initialize(name)
        @name = name
    end
end

# we can save the objects state using the dump method
player = Player.new("John")
player.progress = 60

player_out = Marshal.dump(player)

puts player_out.inspect #=> "\x04\bo:\vPlayer\a:\n@nameI\"\nJohn\x06:\x06ET:\x0E@progressiA"

# the data can be read back later using the load method
player_in = Marshal.load(player_out)
puts player_in.inspect