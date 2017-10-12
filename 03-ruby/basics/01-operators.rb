# ** exponent, 3 ** 2 == 9, 3 ** 3 == 27

# basic math operators with assignment
a = 2

a += 2
a *= 4
a -= 3
a  /= 2
a %= 1
a **= 2 

name = "John"
name += " Smith" #=> John Smith

name *= 2 #=> "John SmithJohn Smith"

# equality operators
# 1. ruby does not have the === and !== (strict equality and strict inequality)
#    not required since you there's no coercion of string to numbers or vide versa
# 2. When comparing 2 array's or objects with the same values/properties
#    => in javascript using == or ===, comparison would be FALSE
#    => in ruby using == the comparison is TRUE
a = [1,2]
b = [1,2]
a == b #=> true

c = {"name" => "John"}
d = {"name" => "John"}
c == d #=> true


puts "Enter your age at the prompt"
age gets.chmop
age = age.to_i

if age > 60
    puts "You old dog!"
else
    puts "You're still wet behind the ears"
end

# using case statement 
print "Modify your name. Type 'uppercase' or 'reverse': "
answer = gets.chomp.downcase

case answer 
when "reverse"
  puts "This is your name backwards:"
  puts name.reverse
when "uppercase"
  puts "This is your name in all uppercase letters:"
  puts name.upcase
when "both"
  puts name.reverse.upcase
else
  puts "Ok, maybe later."
end