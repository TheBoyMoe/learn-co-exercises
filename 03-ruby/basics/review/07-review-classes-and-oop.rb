# instead of having an object and a method that uses that object, e.g.

person = {
    first_name: 'Tom',
    last_name: 'Jones'
}

def user_info(person)
    "#{person[:first_name]} #{person[:last_name]}"
end

puts user_info(person)

class Person
    attr_accessor :first_name, :last_name

    def user_info
        "#{@first_name} #{@last_name}"
    end
    
end

instance = Person.new
instance.first_name = "Grace"
instance.last_name = "Jones"
puts instance.user_info


class Dog
    @@all = [] #class variable
    attr_accessor :weight, :age, :color # use attr_accessors/_reader/_writer instead of getters/setters

    def initialize
        bark
        @birthday = Time.now
        @@all << self # instance of self is added to array
    end

    def bark
        puts 'woof woof woof'
    end

    # class method
    def self.all
        @@all # returns the @@all array
    end

    # getters and setters => 
    def name=(new_name)
        @name = new_name
    end

    def name
        @name
    end
end

fido = Dog.new
fido.name = 'fido'