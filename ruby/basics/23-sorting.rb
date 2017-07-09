### sorting in ruby ###

array = [7, 3, 1, 2, 6, 5]
strs = ['apple', 'lime', 'orange', 'lemon', 'rasberry', 'strawberry', 'lemons', 'limes']
 
array.sort do |a, b|
  if a == b
    0
  elsif a < b
    -1
  elsif a > b
    1
  end
end

# short hand version
array.sort do |a, b|
  a <=> b
end

# to sort arrays of numbers or strings in ascending order
puts array.sort.inspect #=> [1, 2, 3, 5, 6, 7]
puts strs.sort.inspect #=> ["apple", "lemon", "lemons", "lime", "limes", "orange", "rasberry", "strawberry"]

# sort an array in descnding order
result = array.sort do |a,b|
    b <=> a
end
puts result.inspect #=> [7, 6, 5, 3, 2, 1]

result = strs.sort do |a,b|
    b <=> a
end
puts result.inspect #=> ["strawberry", "rasberry", "orange", "limes", "lime", "lemons", "lemon", "apple"]