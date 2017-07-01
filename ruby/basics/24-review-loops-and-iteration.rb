### loops ###

count = 0
sum = 0
loop do
    break if count == 10 
    sum += 4
    count += 1
end

puts "sum #{sum} count #{count}"

acc = 0
num = 5
num.times do
    acc += 2
end
puts "1st loop #{acc}"

num.times do |i| # sends in the index
    acc += i
end
puts "2nd loop #{acc}"

num.times { acc += 2 }
puts "3rd loop #{acc}"


# while loop - executes while the condition is true
while count > 0
    acc += 2
    count -= 1
end
puts "while loop #{acc}"

# until loop - executes while the condition is false (until it's true)
until count == 10
    acc += 2
    count += 1
end
puts "until loop #{acc}"

# do while loop
begin
    acc += 2
    count -= 1
end while count > 0
puts "do while loop #{acc}"

### array iteration ###

# each iterator
array = [1,2,3,4,5,6,7,8]
arr = []
array.each do |val|
    arr.push(val * 2)
end
puts arr.inspect
arr = []

# each with index
array.each_with_index do |val, i|
    arr.push(val * i)
end
puts arr.inspect

# for loop (an iterator - works like each method)
for val in 1..10 do
    arr.push(val)
end
puts arr.inspect

arr2 = []
words = ['string', 'number', 'boolean', 'nil', 'hash', 'array']
for word in words do
    arr2.push(word.upcase.reverse)
end
puts arr2.inspect


### hash iteration ###
hash = {name: 'Tom Jones', adddress: 'the street, the city, postal code', phone: 123456789, age: 56}
hash.each do |key, value|
    puts "#{key} : #{value}"
end

hash.each_key do |key|
    puts "key: #{key}, value: #{hash[key]}"
end

hash.each_value do |value|
    puts "value: #{value}"
end
