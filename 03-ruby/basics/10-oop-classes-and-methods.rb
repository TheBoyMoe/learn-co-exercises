class Dog
    
    #setter
    def name=(dog_name)
        @this_dogs_name = dog_name
    end

    # getter
    def name
        @this_dogs_name
    end

    def info
        puts "My name is #{@this_dogs_name}"
    end

    def bark
        puts "woof woof woof!"
    end
end

fido = Dog.new

puts fido
puts fido.object_id
# puts fido.methods

fido.name = "Fido"
fido.info



class Name

    def initialize(title, first_name, middle_name, last_name)
        @title = title
        @first_name = first_name
        @middle_name = middle_name
        @last_name = last_name
    end

    def title
        @title
    end

    def first_name
        @first_name
    end

    def middle_name
        @middle_name
    end

    def last_name
        @last_name
    end

end 

name = Name.new("Mr.", "John", "Paul", "Jones")
puts "#{name.title} #{name.first_name} #{name.middle_name} #{name.last_name}"


### Create Attribute Reader & Writer ###

# Our name class has 4 getter methods title, first_name, etc to allow us to access
# the name's attributes from outside of the class. Instead of creating these, 
# we can use an attribute reader - giving us access to the same variables outside that class.
# Ruby provides a atrribute writer allowing us to set the instance attributes
# Using attribute reader/writer means we avoid writing getter and setter methods

# Where you have attributes defined with attribute reader and writer, you can 
# replace with att_accessor 


class Person
    attr_reader :first_name, :middle_name, :last_name
    attr_writer :first_name, :last_name
    attr_accessor :title

    def initialize(title, first_name, middle_name, last_name)
        @title = title
        @first_name = first_name
        @middle_name = middle_name
        @last_name = last_name
    end

    def full_name
        "#{@first_name} #{@middle_name} #{@last_name}"
    end

    def full_name_with_title
        "#{@title} #{full_name}"
    end

    def test
        # local variable not accessible to othe methods in the class
        # @variables are instance variables, accessible throughtout the class
        # the test method (getter) makes the phone number visible outside the class, 
        # just as attr_readers or accessors do
        phone_number = 123456789
    end

    # A common idiom is to define a `to_s` method, defines how to print a class.
    # Automatically called when an object needs to be formatted as a string
    def to_s
       full_name_with_title 
    end

end

person = Person.new('Sir', 'Tom', '', 'Jones')
puts "#{person.title} #{person.first_name} #{person.middle_name} #{person.last_name}"