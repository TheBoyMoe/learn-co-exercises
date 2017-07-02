### String methods that take blocks ####

string = 'I\'m hungry, let\'s get a taco'

# each_char method
string.each_char do |char|
    print "#{char} "
end
puts 

# each_byte - returns ascii code for each char
string.each_byte {|char| print "#{char} "}
puts


### Integer methods ###

# downto

10.downto(0) {|val| print "#{val}.. " }
print ' blast off!'
puts

# upto

1.upto(10) {|v| print "#{v} "}
puts

# times

10.times do |i|
    print "#{i}.. "
end
print ' lift off!'
puts


### Array methods ###

array = [1,2,3,4,5,6,7,8]

# each
array.each {|v| print "#{v}.. "}
puts

# each_with_index
array.each_with_index {|v, i| puts "#{i}: #{v}"}

# reverse_each
array.reverse_each {|v| print "#{v}  "} #=> '8  7  6  5  4  3  2  1'
puts

# map - returns a new array
arr = array.map {|v| v*2}
puts arr.inspect
puts array.inspect

# select, reject and drop_while - all return a new array, living the original unchanged
arr1 = array.select {|v| v > 4} #=> [5, 6, 7, 8]
arr2 = array.reject {|v| v < 4} #=> [4, 5, 6, 7, 8]
arr3 = array.drop_while {|v| v < 4} #=> [4, 5, 6, 7, 8]
puts array.inspect #=> #=> [1, 2, 3, 4, 5, 6, 7, 8]

# keep_if and delete_if - both are destructive
arr4 = array.keep_if {|v| v > 2} #=> [3, 4, 5, 6, 7, 8]
puts array.inspect #=> [3, 4, 5, 6, 7, 8]

arr5 = array.delete_if {|v| v > 6} #=> [3, 4, 5, 6]
puts array.inspect #=> [3, 4, 5, 6]


# any?, all? none? - array unchanged
array.any? {|v| v.odd?} #=> true
array.all? {|v| v.even?} #=> false
puts array.none? {|v| v > 10} #=> true


### hash mehods ###
hash = {name: 'Tom Jones', address: 'the street, town, city', phone: 123456789}

# each, each_pair, each_key, each_value - hash remains unchanged
hash.each {|key, value| print "#{key}: #{value} "}
puts
hash.each_pair {|key, value| print "#{key}: #{value} "}
puts
hash.each_key {|key| print "#{key} "}
puts
hash.each_value {|val| print "#{val} "}
puts

# select, reject - original reamins unchanged
hash.select {|key, val| key == :phone} #=> {:phone=>123456789}
hash1 = hash.reject {|key, value| key == :phone} #=> {:name=>"Tom Jones", :address=>"the street, town, city"}

# keep_if
hash1 = hash.keep_if {|key, value| key == :name || key == :phone} #=> {:name=>"Tom Jones", :phone=>123456789}
puts hash #=> {:name=>"Tom Jones", :phone=>123456789}
