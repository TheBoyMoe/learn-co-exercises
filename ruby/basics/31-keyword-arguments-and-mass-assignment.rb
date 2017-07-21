# Using keyword arguments with default values - call the method with out arguments
def happy_birthday(name: 'Tom', age: 61)
  puts "Happy birthday #{name}"
  age += 1
  puts "You're #{age} years old!"
end

# define the method to take keyword arguments - reference the args without the : in the method, just by their name.
def user_info(salutation:, surname:, address:, age:)
  puts "Hello #{salutation} #{surname}, \nyou live at #{address} \nand will be #{age += 1} at your next birthday"
end

# example - args can be in any order when calling the method, using the key/value format
user_info(age: 44, salutation: 'Mr', address: '1 the Street, London', surname: 'Jones')
user_info(salutation: 'Mr', address: '1 the Street, London', age: 33, surname: 'Jones')
user_info(salutation: 'Mr', surname: 'Smith', address: '1 the Street, London', age: 33)

=begin #=> all return the same value
  Hello Mr Jones,
  you live at 1 the Street, London
  and will be 34 at your next birthday
=end


# Mass Assignment - if a method accepts keyword arguments, we can pass it a hash when calling it
class Person
  attr_reader :firstname, :lastname, :age

  def initialize(firstname:, lastname:, age:)
    @firstname = firstname
    @lastname = lastname
    @age = age
  end
end

# example
# john = Person.new({firstname:'John', lastname: 'Smith', age: 33})
 #=> #<Person:0x00000002556b60 @firstname="John", @lastname="Smith", @age=33>

# sophie = {firstname: 'Sophie', lastname: 'Smith', age: 33} #=> {:firstname=>"Sophie", :lastname=>"Smith", :age=>33}
# person = Person.new(sophie)
#=> #<Person:0x000000025c6cd0 @firstname="Sophie", @lastname="Smith", @age=33>
