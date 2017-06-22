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