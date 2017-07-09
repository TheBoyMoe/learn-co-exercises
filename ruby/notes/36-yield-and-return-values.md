# Code Along: Yielding and Return Values


## Objectives

1. Understand how to control the return value of a method that uses `yield`.
2. Gain more practice with the `yield` keyword and blocks.
2. Gain a deeper understanding of the common iterator, `#collect`.

## Why Return Values Matter

Arrays are great for storing lists of information. In the real-world, however, lists change. We might use one list as the basis for collecting information for a different list entirely. 

Think about it like this––you are running a popular social networking site and you have a list of a user's posts. Each post has a timestamp. A post might say "posted 10 minutes ago" or "posted 2 days ago". Every few minutes or so, you need to iterate over the list of posts and update the timestamp accordingly. 

There are many scenarios in which you will want to iterate over a list of items, make some change to each item, and collect the resulting list of altered items. 

This is where controlling the return values of our methods comes in. When we want to iterate over a collection, execute some code using the members of that collection and *return the changed collection*, we need to find a way to collect the changed items and tell our method to return the new and improved collection. 

We already know how to use the `yield` keyword in a method to pass each successive element of a collection to a block of code. Now, let's take a closer look at using `yield` and capturing the return value of the code block that we will call with such a method. 

## Yield and Return Values

**This is a code-along exercise. We've given you some code in `lib/practicing_returns.rb` that we will build on together throughout the course of this reading**. 

Each time you use `yield(some_argument)` in the body of a method, it passes `some_argument` to the block you call that method with. Open up `lib/practicing_returns.rb` and take a look at the following code:

```ruby
def hello(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end
```

In this method, we are using a `while` loop to iterate over an array and yielding each member of the array in turn to a block. 

We would call our method like this:

```ruby
hello(["Tim", "Tom", "Jim"]) { |name| puts "Hi, #{name}" }
```

Which would output to the terminal:

```bash
# > Hi, Tim
# > Hi, Tom
# > Hi, Jim
```

You can run this file in your terminal with `ruby lib/practicing_returns.rb` to see for yourself. 

What is the return value of this method call, though? 

Let's find out! Notice that we have required Pry for you at the top of `lib/practicing_returns.rb` Go ahead and place a `binding.pry` on line 11, just before we call our `#hello` method. 

Run the file with `ruby lib/practicing_returns.rb` in your terminal. We should be dropped right into our binding. 

Inside the Pry console in your terminal, manually invoke the method by copying and pasting the following and hitting `enter`:

```ruby
hello(["Tim", "Tom", "Jim"]) { |name| puts "Hi, #{name}" }
```

You should see the following:

```bash
# > Hi, Tim
# > Hi, Tom
# > Hi, Jim
=> nil
```

Notice that our method `puts`-ed out the code we expected and **returned `nil`**. Why is that?

That is because the return value of a `while` loop is always `nil`. If we want our method to return something else, we have to tell it to do so. 

Let's tell our method to return a new array of strings that contain the above greetings, instead of simply `puts`-ing out our greetings. 

We can capture the return value of the code that is executed when `yield` passes a value to a block. 

## Capturing the Return Value of Using Yield

Make the following change to the code block that we are calling with our `#hello` method in `lib/practicing_returns.rb`:

```ruby
hello(["Tim", "Tom", "Jim"]) { |name| "Hi, #{name}" }
```

Now, the return value of each execution of the code in our block will be a string: `"Hi, #{name}"`. 

Let's take a look at capturing the return value of `yielding` to this block. 

Place a `binding.pry`:

```ruby
def hello(array)
  i = 0
  while i < array.length
    binding.pry
    yield(array[i])
    i += 1
  end
end
```

Now, run the file with `ruby lib/practicing_returns.rb`. You should be dropped right into your binding. Let's manually execute our `yield` so that we can see the return value. In the Pry console in your terminal:

```ruby
yield(array[i])
```

This returns:

```bash
"Hi, Tim"
```

Here, we are looking at the return value of our block's execution with the yielded value of `array[i]`, which at this point in our iteration is equal to `"Tim"`.

Now that we understand that calling `yield(some_argument)` will give us the return value of the execution of the block with that argument, we can capture those return values.

```ruby
def hello(array)
  i = 0
  collection = []
  while i < array.length
    collection << yield(array[i])
    i += 1
  end
end
```

Here we are setting a variable, `collection`, equal to an empty array. Then, inside our `while` loop, we push the return value of using `yield(array[i])` into that `collection` array. 

Lastly, we need to return that new `collection` at the end of our method:

```ruby
def hello(array)
  i = 0
  collection = []
  while i < array.length
    collection << yield(array[i])
    i += 1
  end
  collection
end
```

And that's it! We've successfully built our own iteration using a `while` loop, `yield`ed each individual member of an array to a block and captured the return values of yielding those items to the block. This is exactly how the `#collect` method works, and we've just built it out, all by ourselves. 
