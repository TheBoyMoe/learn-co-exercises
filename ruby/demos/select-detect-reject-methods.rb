
#####################################################
# select
#####################################################

# select returns a new array of the elements that eveluated as true
# original array is unchanged
evens = [1,2,3,4,5,6,7,8,9].select do |value|
    value.even?
end

[1,2,3,4,5].select{|i| i.odd?} #=> [1,3,5]
 
[1,2,3].select{|i| i.is_a?(String)} #=> []



########################################################
# detect (find)
########################################################

# detect/find returns the first element that eveluates as true
# original array is unchanged

[1,2,3].detect{|i| i.odd?} #=> 1
[1,2,3,4].detect{|i| i.even?} #=> 2
[1,2,3,4].detect{|i| i.is_a?(String)} #=> nil




########################################################
# reject
########################################################

# reject is the oposite of select, returning an array of the 
# values which eveluated as false, original array is unchanged

[1,2,3,4,5,6,7,8,9].select do |value|
    value.even?
end
# [2,4,6,8]

[1,2,3,4,5,6,7,8,9].reject do |value|
    value.even?
end
# [1,3,5,7,9]
