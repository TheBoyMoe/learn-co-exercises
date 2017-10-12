# Code Along: Building the `all?` method 

##Objectives
* Continue to practice using yield and blocks
* Gain a deeper understanding of `#all?`


##Code Along Exercise

Fork and clone this lab. You'll be coding your solution in `lib/my_all.rb`. If at any point you want to follow along with the example, you can put a `binding.pry` anywhere in the method and run `ruby bin/my_all` in your terminal to pry around.

###Step 1
We need to iterate through each element in the passed in collection using the simple lower level iterator `while`. Remember, since this is a lower level iterator, we will need to explicitly add a counter we'll call `i`, and increment it each time we go into the loop (`i = i + 1`):

```ruby
def my_all?(collection)
  i = 0
  while i < collection.length
    i = i + 1   #i += 1 does the same thing. Use this if it's easier for you.
  end
end
```


###Step 2
We're going to `yield` each element in the collection to the block. Let's look at the code and break down what's happening.

```ruby
def my_all?(collection)
  i = 0
  while i < collection.length
    yield(collection[i])
    i = i + 1
  end
end
```

When this code is run and it hits the `yield` line, it is going to send whatever is passed in as the argument to the block. 

*Note: If you are confused about where the block comes from, it becomes clearer after the method is called. Here's an example:*

```ruby
my_all?([1,2,3]) {|i| i < 2}
```

As this code executes it will look like this:

```ruby
def my_all?([1,2,3])
  i = 0
  while i < 3
    yield(1)
    i = 0 + 1
  end
end
```

When it hits the `yield(1)`, it is going to send `1` to the block, evaluate it, and send the return value back to `yield`:

```ruby
my_all?([1,2,3]) {|1| 1 < 2}
  #=> true
```

In this example, ruby will send `true` (the return value of the block) back to the `my_all?` method because `1 < 2` evaluates to `true`.

###Step 3: Save the return value of the yield block 
Since, we are looping through several elements in an array, what data structure can we use to store multiple values? An array! First, we'll declare our array before entering the `while` loop: `block_return_values = []`. Then, in the loop, let's shovel (`<<`) the return value of the block into the array: `block_return_values << yield(collection[i])`.

```ruby
def my_all?(collection)
  i = 0
  block_return_values = []
  while i < collection.length
    block_return_values << yield(collection[i])
    i = i + 1
  end
end
```

###Step 4: Determine the return value of the method
The return value of `all?` is simply `true` or `false`. If any element in the collection evaluates to false, then `all?` should return `false`. If they are all true, the method should return `true`. 

Right now, we have access to an array of return values `block_return_values`. All we have to do now is determine whether the array contains any `false` elements.

Sticking with our previous example:

```ruby
my_all?([1,2,3]) {|i| i < 2}
```
Our `block_return_values` would look like this:

```ruby
block_return_values = [true, false, false]
```
Let's just add an `#include?` method to determine the return value of the `my_all?` method. After we have the return value, we are all set. The final product will look like this:

```ruby
def my_all?(collection)
  i = 0
  block_return_values = []
  while i < collection.length
    block_return_values << yield(collection[i])
    i = i + 1
  end
  
  if block_return_values.include?(false)
    false
  else
    true
  end
end
```
