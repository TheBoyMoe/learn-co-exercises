def myFirstMethod
    put 'This is my First Method'
end

def using_optional_args(one = 1, two)
    one + two
end   

# puts using_optional_args(5)

def more_optional_args(one, two = 2)
    one + two
end 

# puts more_optional_args(3, 3)


def both_default_args(one = 2, two = 3)
    one + two
end

# puts both_default_args(3)

def default_first(one = 1, two)
    one + two
end

# puts default_first(10)

def default_with_strings(language = 'Ruby', name)
    puts "Hi #{name}, I here you're a great #{language} programmer"
end

default_with_strings('Java', 'Sophie')
default_with_strings('John')

john = ['John Smith', 34, 'Developer', '0208 540 9218']

def print_business_card(person)
    puts "Name: #{person[0]}, Age: #{person[1]}, Occupation: #{person[2]}"
end

print_business_card(john)


colors = ['red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet']

def display_rainbow(array)
    puts "R: #{array[0]}, O: #{array[1]}, Y: #{array[2]}, G: #{array[3]}, B: #{array[4]}, I: #{array[5]}, V: #{array[6]}"
end

display_rainbow(colors)