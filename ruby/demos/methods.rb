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