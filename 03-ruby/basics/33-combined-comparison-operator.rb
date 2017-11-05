=begin

The Combined Comparison Operator

We can also use a new operator called the combined comparison operator to compare two Ruby objects. The combined comparison operator looks like this: <=>. It returns 0 if the first operand (item to be compared) equals the second, 1 if the first operand is greater than the second, and -1 if the first operand is less than the second.

A block that is passed into the sort method must return either1, 0, or -1. It should return -1 if the first block parameter should come before the second, 1 if vice versa, and 0 if they are of equal weight, meaning one does not come before the other (i.e. if two values are equal)

The sort method assumes by default that you want to sort in ascending order, but it accepts a block as an optional argument that allows you to specify how two items should be compared.


=end

books = ["Charlie and the Chocolate Factory", "War and Peace", "Utopia", "A Brief History of Time", "A Wrinkle in Time"]

# To sort the books in ascending order, in-place
books.sort! { |firstBook, secondBook| firstBook <=> secondBook }

# Sort the books in descending order, in-place below
books.sort! {|a,b| b <=> a}
