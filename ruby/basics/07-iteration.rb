=begin
    References
    [1] http://ruby-doc.org/core-2.0.0/Hash.html#method-i-each
    [2] http://ruby-doc.org/core-2.0.0/Hash.html#method-i-each_key
    [3] http://ruby-doc.org/core-2.0.0/Hash.html#method-i-each_value
=end

# iterate over an array using each -  does not affaect the array
# a copy of the value is passed in to the loop
array = [1,2,3,4,5,6,7,8]

array.each do |val|
    puts "Item #{val}"
end


# iterate over hashes, none of the methods affect the hash itself

# iterate over a hash using #each or #each_pair
hash = {'name' => 'Business Supplies', 'address' => '1 the street, london, WC1', 'city' => 'london', 'country' => 'uk'}
hash.each do |key, value|
    # do something ....
end

hash.each_pair do |key, value|
    # do something...
end

hash.each_key do |key|
    # do something...
end

hash.each_value do |value|
    # do something...
end


# times iterator - execute the statements in the block n times
5.times do
    # execute block * 5
end

# times iterator optionally takes a single argument, an index, which starts at 0 
5.times do |value|
    puts "Value #{value}" 
end
#=> "Value 0"
#=> "Value 1"
#=> .....
#=> "value 4"

# using times to iterate over an array
(array.length).times do |i|
    array[i] = array[i]*2
end
puts array.inspect #=> [2,4,6,8,10,12,14,16]


### for loop ###

=begin
Most Ruby programmers don't use the for loop very often, instead 
preferring to use an "each" loop and do iteration. The reason for 
this is that the variables used to iterate in the for loop exist 
outside the for loop, while in other iterators, they exist only 
inside the block of code that’s running.

the for loop functions like an iterator, working like the #each method

=end

# The following for loop creates a range from 1 to 10 and 
# then passes the value in to the block on each iteration:
for value in 1..10 do
    puts "The current item is: #{value}"
end

# using a for loop with an array
arr = ['alpha', 'bravo', 'charlie', 'delta', 'echo']
for item in arr do
    puts "array item: #{item}"
end

# or
for item in ["Programming", "is", "fun"] do
  puts "The current item is #{item}."
end