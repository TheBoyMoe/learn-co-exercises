###################################################
# all?
###################################################
# determine if all the values in an array are odd
all_odd = true
[1,2,3,4,5,6,7,8,9].each do |value|
    if value.even?
        all_odd = false
    end    
end    

# all? must reurn true for every iteration 
# for the entire expression to return true
all_odd = [1,2,3,4,5,6,7,8,9].all? do |value|
    value.odd?
end    
all_odd #=> false


####################################################
# none?
####################################################
none_even = true
[1,3,5,7,9,11,13,15].each do |value|
    if value.even?
        none_even = false
    end    
end    
none_even #=> true

# none? all values evaluated must return false, for 
# the overall expression to evaluate as true
[1,3,5,7,9,11,13,15].none? do |value|
    i.even?
end


####################################################
# any?
####################################################

# at least one value evaluates as true, false otherwise
[1,3,5,7,8,6,10,23].any? do |value|
    value > 10
end


####################################################
# include?
####################################################

# returns true if a given element exists in the array, false otherwise
[1,2,4,6,7,8].include?(6) #=> true
[1,2,4,5,6,7].include?(12) #=> false