# Create an array:
array = Array.new #=> []

# Create an array with three items:
array = Array.new(3, "John") #=> ['John', 'John', 'John']

# Create an empty array with bracket notation:
array = []

# Create an array using brackets with three items:
array = ["milk", "eggs", "bread"]

# Create an array using the %w notation which contains three strings:
array = %w(milk eggs bread)

# Create an array using the %W notation which contains three strings and one is interpolated:
item = 'milk'
array = %W(#{item} eggs bread)

# or

arr = [item, 'eggs', 'bread'] #=> ['milk', 'eggs', 'bread']


#### Adding values to arrays - you can add any ruby type ########

# Add the string "carrots" to the end of the array using 'shovel' operator - single values
arr << "carrots" #=> ['milk', 'eggs', 'bread', 'carrots']

#Add values to the end of the array:
array.push('potatoes', 'celery', 'cabbage') # append multiple items at once

# Add values to the beginning of the array:
array.unshift('beer', 'lager', 'ale') # add to beginning

# Add the strings "ice cream" and "pie" to the end of the array, concat - multiple values:
array += ["butter", "ham"] #=> ['milk', 'eggs', 'bread', 'carrots', 'butter', 'ham']

# Add the number 1 to the end of the array:
array << 1

# 'Stringify' array to view on screen, puts array prints each value on a separate line
puts array.inspect #=> ['milk', 'eggs', 'bread', 'carrots', 'butter', 'ham']


###### Accessing items in an array #####

# Return the item at a particular index in an array
item = array[3] #=> 'carrots'
item = array.at(3) 

# fetch the first item in the array using the first method:
first = array.first #=> 'milk', original array is unchanged

# fetch the last item in the array, using the negative index and 
# also the "last" method - aray remains unchanged:
last = array[-1] #=> 'ham', you can also use -2,-3, etc
last = array.last

# The fetch method can be used with an index to return that item in an array:
item = array.fetch(2)    # => "bread", array remains unchanged

# If a second argument is provided to the fetch method and there is no corresponding item in the array, the second argument will be used as a default:
item = array.fetch(20, "cake")    # => "cake"

# Return the number of items in an array:
array.length
array.count
array.size

# Return the number of items in the array matching what you send in:
array.count("eggs")  # => 1

# To find out if an array contains a particular item, use the include? method with the argument of the desired item:
array.include?("eggs")  # => true

# insert values into the array at a particular index
array.insert(4, 'orange juice') # following items shift to right
puts array.inspect

#### Removing values from an array  #######

# remove the last item in the array, we can use the pop method:
last_item = array.pop

# remove the first item in the array, we use the shift method:
first_item = array.shift

# both pop() and shift() return the item and change the original array

# Use the drop method to remove multiple items from the front of the array.
# returns an array of the remaining items, original array is unchanged
# drops x number of items from the front, returns the remaining
items = array.drop(2)

# The slice method takes two arguments 1st arg is the index of the starting point, and the 2nd is the number of items:
# returns a new array, original is unchanged
first_three_items = array.slice(0, 3)


#### Miscelaneous Array methods ###### 

# determine the index of an item in the array
puts array.index('orange juice') # 3, returns nil if not found

# sort an array - returns a sorted copy using <=> operator, ascending for numbers, alphabetically for strings
array.sort
array.sort! #=> execute the sort in-place, changes original

# reverse an array - reurns a reversed copy, append ! operator to do an in-place reverse
array.reverse
array.reverse! #=> in-place reverse

# combining the two - in-place sort-reverse
array.sort!.reverse!

# determine if an array contains a particular value, returns boolean
array.include?('bread')

# convert string to array - use the split method
string = "hippo,giraffe,monkey,horse"
"hippo,giraffe,monkey,horse".split(",") #=> ["hippo", "giraffe", "monkey", "horse"]

# convert a range to an array, use to_a method
(1..10).to_a #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# convert an array to a string, use join method
["a", "b", "c"].join #=> 'abc'
["a", "b", "c"].join(' ') #=> 'a b c'