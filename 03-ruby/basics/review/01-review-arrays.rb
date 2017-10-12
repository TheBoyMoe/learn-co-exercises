## arrays ##

array = ['word string', 1]


# append items to array end
array << [8,5,3,1]
array.push({'price' => 2.32, 'weight' => '32.0kg'})

# concat items to end of array
array += [99,98,97,96] # add individual items
array += [{name: 'John Paul Jones'},{name: 'Grace Jones'}]
array += [[12,13,14], [21, 22, 23]] # add arrays

# concat or += takes an aray of values
array = (1..9).to_a.unshift(0).push(11) #=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11]
array += [12,13,14,15] #=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15]
array += [[16,17,18], [19,20,21]] #=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, [16, 17, 18], [19, 20, 21]]
array += [[22,23,24], 25,26,27] #=>  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, [16, 17, 18], [19, 20, 21], [22, 23, 24], 25, 26, 27]
array.concat([31,32,33]) #=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, [16, 17, 18], [19, 20, 21], [22, 23, 24], 25, 26, 27, 30, 31, 32]

puts array.inspect

# add items to begining of array - both push() & unshift() return the array
array.unshift(111,324,342)
puts array.inspect

# accessing array items
puts array.at(0) #=> 111, array unchanged
puts array.first #=> 111
puts array.last.inspect #=> [21, 22, 23]
puts array[-1].inspect #=> [21, 22, 23]

puts array.inspect


arr = [1,2,3,4,5,6,7,8,9,10]

# remove items from arrays - pop and shift return the item
puts arr.pop
puts arr.shift

#any? returns true or false depending on the results of the block
arr.any? {|val| val == 10} #= > true

#drop return copy with 1st 3 items removed, array unchanged
items = arr.drop(3)
puts "items #{items}"

# delete items from an array - #delete, #delete_at & delete_if
arr.delete(8) #=> 8 delete and return value if a match if found, array changed
arr.delete_at(2) #=> 3 delete & return the value at that index, array changed
arr.delete_if {|val| val % 2 == 0} #=> deletes every value which the block evaluates as true - returns che changed array

# check if the array has any elements
array.empty? #=> false

# check if two arrays are equal, #eql? or == (values must be in the same order)
arr = [1,2,3,4]
arr.eql?([1,2,3,4]) #=> true

# flatten an array #flatten (returns a copy)  & flatten! (flattens inplace)
arr = [[1,2,3,4], [[[5,6], [7,8]], 10,11], [[[[13,14,15], [[18,19]]]]]]
arr.flatten #=> [1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 13, 14, 15, 18, 19]


# check if the aray contains a particular value
('a'..'i').map {|char| char * 2}.include?('hh') #=> true
(0..20).map {|v| v}.include?(19) #=> true

# return the index of the first match #index
('a'..'i').map {|e| e}.index('f') #=> 5

# insert value(s) into the array before the index
%w{a b c d e f}.insert(2, 'x', 'y', 'z') #=> ["a", "b", "x", "y", "z", "c", "d", "e", "f"]

# iterate through an array #each, #each_with_index, #each.with_index(), #map, #map!
# all the each's return the original array
# each_with_index -> pass in an index
# each.with_index -> start the index at a number other than 0
# map -> returns a new array
# map! -> alters the original array

# min/max - return the min/max value
# if using with objects, assumes thay implement Comparable
%w[dog mouse hampster tiger giraffe].max {|a,b| a.length <=> b.length} #=> 'hampster'

# reject & select,
# reject retuns a new array for which for which the given block is false
# select returns a new array for which for which the given block is true
# reject! and select! change the original array (reject! deletes values evaluating as true, select! deletes those evaluating as false)


# reverse and reverse! - reverse the values
# reverse returns a new array, reverse! returns the original

# shuffle and shuffle! - return an array with the elements shuffled
# shuffle returns a new array, shuffle! returns the original

# slice - original array unchanged, slice! acts on the original array
# negative indices start from the end
array = %w[dog mouse hampster tiger giraffe]
array.slice(2) #=> 'hampster' -> returns element at given index
array.slice(0,2) #=> ['dog', 'mouse'] -> first arg is the start, 2nd is the number of elements to return

# sort - returns a new array, sort! - acts on the original
[1,3,6,2,7,9,5,0,9,3, 11,12, 13].sort {|a,b| a <=> b} #=> [0, 1, 2, 3, 3, 5, 6, 7, 9, 9, 11, 12, 13]

# uniq - removes duplicates, returning new array
# uniq! acts on the original array
