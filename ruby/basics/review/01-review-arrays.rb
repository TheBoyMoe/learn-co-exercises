## arrays ##

array = ['word string', 1]


# append items to array end
array << [8,5,3,1]
array.push({'price' => 2.32, 'weight' => '32.0kg'})

# concat items to end of array
array += [99,98,97,96] # add individual items
array += [{name: 'John Paul Jones'},{name: 'Grace Jones'}]
array += [[12,13,14], [21, 22, 23]] # add arrays

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


# misc array methods

items = arr.drop(3) # return copy with 1st 3 items removed, array unchanged
puts "items #{items}"

arr2 = arr.slice(0, 3) # create copy, upto, not including index 3, array unchanged
puts "slice #{arr2.inspect}"
puts arr.inspect

puts arr.include?(3) #=> true
puts arr.insert(2, 11).inspect #=> [1,2,11,3,4,5] insert at index 2, shift following elements

