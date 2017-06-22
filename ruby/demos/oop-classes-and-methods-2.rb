class Person
    def initialize(name, age, address)
        @name = name
        @age = age
        @address = address
    end

    # getter
    def name
        @name
    end

    #setter
    def name=(name)
        @name = name
    end

    def info
        "My name is #{@name}, I'm #{@age} years old and I live at #{@address}"
    end
end

person = Person.new("Tom Jones", 68, "1 the street, London, UK")
puts person.info
person.name = "John Paul Jones"
puts person.info