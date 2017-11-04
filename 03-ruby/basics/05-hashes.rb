=begin
    References
    [1] http://ruby-doc.org/core-2.1.2/Hash.html

=end

# rescue => exception
#
# else
#
# ensure
#
# end

# create a hash by instantiating a new instance of the Hash class:
item = Hash.new

# Hashes can also be created by using curly braces:
item = {}

# keys and values can also be specified:
item = { "item" => "Bread", "quantity" => 1 }

# Hash keys can be almost any Ruby type, most common are strings, numbers & symbols:
item = { :item => "Bread", :quantity => 1 }

# You can use a variable as a key as long as it references a ruby type that can be used as a key
obj = {'name' => 'bread'}
quantity = 'number'
obj[quantity] = 3 #=> {'name' => 'bread', 'number' => 3}

# you can use either form of the variable to access it's value
obj[quantity] #=> 3
obj['number'] #=> 3


# Hash keys can also be numbers. If we set the following hash key and value:
item[1] = "Grocery Store" #=> { :item => "Bread", :quantity => 1, 1 => "Grocery Store" }

# Once a hash has been instantiated, it is possible to add new hash keys and values by using
# the name of the hash, brackets containing the new key, an equals sign, and the new value for said key:
item["brand"] = "Treehouse Bread Company"

# If you're using symbols as keys, there's a shorthand notation you can use.
# So if you're defining a hash like this...

item = { :item => "Bread", :quantity => 1 }

# ...you can move the colons after the symbols, and omit the arrows.
# This hash will be identical to the one above:

item = { item: "Bread", quantity: 1 }


##### Keys ############
hash = { "item" => "Bread", "quantity" => 1, "brand" => "Treehouse Bread Company" }

# To find all of the keys inside of the hash use the keys() method, returns an array:
hash.keys #=> ["item", "quantity", "brand"]

# To check whether or not a hash contains a key, we can use the has_key? (which has aliases: member? or key?) method,
# which returns true or false. You can use a variable where it references the key
hash.has_key?("brand")      # => true
hash.member?("quantity")    # => true
hash.key?("item")           # => true


# Two hashes are considered equal when they have the same keys and values:

milk = { "item" => "Milk", "quantity" => 1, "brand" => "Treehouse Dairy" }

puts milk == hash     # => true

bread = { "item" => "Bread", "quantity" => 1, "brand" => "Treehouse Bread Company" }

puts hash == bread     # => false


#########  Values #############

# to retrieve a particular key's value, obj is unchanged
hash.fetch('quantity') #=> 1
hash['quantity'] #=> 1

# To return an array of the values in the hash, we can use the values method:
hash.values #=> ["Bread", 1, "Treehouse Bread Company"]

# The values_at method takes several arguments and returns the hash values at the specified keys as an array:
hash.values_at("quantity", "brand") #=> [1, "Treehouse Bread Company"]

# The has_value? (alias value?) method takes one argument and returns true or false if the value is contained within the hash:
hash.has_value?("brand") #=> false
hash.has_value?("Bread") #=> true
hash.value?('Bread') #=> true

######## Changing Values #############

# Use the store() method to add a key/value pair to a hash:
hash.store("calories", 100)
hash['calories'] = 100

#=> { "item" => "Bread", "quantity" => 1, "brand" => "Treehouse Bread Company", "calories" => 100 }


### Useful hash methods ######

# The length method will return the number of keys in the hash (aliases - count and size)
hash.length #=> 4
hash.count #=> 4
hash.size #=> 4

# The invert method returns a new hash with the keys and values transposed, original unchanged
hash.invert #=> {"Bread" => "item", 1 => "quantity", "Treehouse Bread Company" => "brand"}

# The shift method works similar to hashes as it does with arrays.
# It will REMOVE a key and value pair from the hash and return it as an array:
hash.shift #=> ["item", "Bread"]

# The original hash would also be modified:
#=> {"quantity" => 1, "brand" => "Treehouse Bread Company"}

# The merge method combines the hash sent in as an argument and returns a new hash with the two combined:
# original is unchanged
hash.merge({"calories" => 100}) #=> {"quantity" => 1, "brand" => "Treehouse Bread Company", "calories" => 100}

# If any key value pairs exist in the original hash, the values in the merge obj are used:
hash.merge({"quantity" => 100}) #=> {"quantity" => 100, "brand" => "Treehouse Bread Company", "calories" => 100}


#  count word frquency in a sentence using a hash
puts "Enter a sentence"
text = gets.chomp
words = text.split(' ')
# create a hash with a default value
# to access the default value, try accessing the value of a non-existant key
frequencies = Hash.new(0)
# The first time we find the word, it will have a default value of`0
words.each do |word|
  frequencies[word] += 1
end

# sort the hash based on word count, smallest to highest
frequencies = frequencies.sort_by {|word, count| count}

frequencies.reverse!
frequencies.each {|k,v| puts "#{k} #{v}"}
