## hashes ##

# creating hashes

grace_jones = {'name' => 'Grace Jones', 'age' => 43} # obj literal
puts grace_jones

john_jones = Hash.new # hash class
john_jones['name'] = 'John Paul Jones'
john_jones['age'] = 54

puts john_jones

# create hashes with symbols

simon_jones = {:name => 'Simon Jones', 'age' => 65}
simon_jones[:address] = 'The street, in the town, in the country'
puts simon_jones

tom_jones = {name: 'Tom Jones', age: 65} # shorthand
tom_jones[:address] = '1 The Street, Town, City'
tom_jones.store(:phone, 123456789)
puts tom_jones

# hash methods
puts tom_jones.keys.inspect #=> [:name, :age, :address]
puts grace_jones.keys.inspect #=> ['name', 'age']

puts tom_jones.has_key?('name') #=> false
puts tom_jones.key?(:name) #=> true
puts tom_jones.member?(:name) #=> true

puts tom_jones.has_value?('Grace Jones') #=> false
puts tom_jones.value?('Tom Jones') #=> true
puts tom_jones.values_at(:name, :phone).inspect #=> ['Tom Jones', 123456789]
puts grace_jones.fetch_values('name', 'age').inspect #=> ['Grace Jones', 43] 

puts tom_jones.shift.inspect #=> [:name, 'Tom jones']
puts tom_jones #=> {:age=>65, :address=>"1 The Street, Town, City", :phone=>123456789}

paul_jones = tom_jones.merge({name: 'Paul Jones', phone: 111111111, mobile: 0771234675}) # conflicts overwritten
    #=> {:age=>65, :address=>"1 The Street, Town, City", :phone=>111111111, :name=>"Paul Jones", :mobile=>132463037}
puts paul_jones # merge creates a new hash
puts tom_jones # original unchanged

tom_jones.store(:name, 'Tom Jones')
puts tom_jones