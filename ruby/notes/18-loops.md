# Looping

## Objectives

2. Introduce the concept of a basic `loop`.
3. Introduce the `break` keyword.
4. Introduce the concept of an incrementing counter.
5. `break` out of a `loop` based on a `counter`.

## Introduction

There are a number of different ways to accomplish looping––the task of telling our program to do something a certain number of times. Here, we'll be looking at the most basic way to build a loop: using the `loop` keyword.

## The `loop` Keyword

The first looping construct that we'll discuss is `loop`. This is the simplest looping construct that we have in Ruby. It simply executes a block (the code that is between the `do` and `end` keywords). Try this in IRB in your Terminal:

```ruby
loop do
  puts "I have found the Time Machine!"
end
```

This will output `I have found the Time Machine!` an infinite number of times in your Terminal. Use `Control`+`C` to break out of the loop in your terminal or just exit the session.

Loops start with the `loop` keyword and are opened by the following `do` and `end` block. All the code that goes inside the `do` and `end` is considered the loop's body or block; that's the code that will execute on repeat.

## Stopping Loops with Break and Counters

Infinite loops will break our program. The `loop` keyword alone will create an infinite loop. Generally, we want to loop only a certain number of times. We can use the `break` keyword inside the body of the loop to exit or abort the loop and continue with the rest of our code. Consider:

```ruby
loop do
  puts "You'll see this exactly once."
  break # Exit the Loop
end

puts "And the Loop is Done"
```

Our loop starts, it prints our message, and then the next line of code, `break` will actually end the loop. A loop that only runs once isn't useful. Neither is a loop that runs forever. So how do we actually build a useful loop, say, that runs exactly 10 times? Well first, we need a counter. Then we need to conditionally break out of the loop when the counter reaches 10. Then we need to increment the counter at every iteration (or execution of the loop).

```ruby
counter = 0 # Start our counter at 0, we have never run the loop
loop do # Start our loop
  # increment our counter by 1 and set it equal to the sum of its current value, plus 1. 
  counter = counter + 1

  # Do Something
  puts "Iteration #{counter} of the loop"

  if counter >= 10 # If our counter is 10 or more
    break # Stop the loop
  end
end
```

If you copy this to IRB you'll see:

```
Iteration 1 of the loop
Iteration 2 of the loop
Iteration 3 of the loop
Iteration 4 of the loop
Iteration 5 of the loop
Iteration 6 of the loop
Iteration 7 of the loop
Iteration 8 of the loop
Iteration 9 of the loop
Iteration 10 of the loop
```

This is a common basic loop. With this construct we can `break` a `loop` based on any condition, but the iteration count is a very common condition for stopping the loop.

## Advanced: The Add-And-Assignment (or Plus-Equals) Operator `+=`  

Above, we use the addition operator (`+`) and the assignment operator `=` separately to reset the `counter` variable to the sum of its old value, plus one, every time we repeat the loop. The add-and-assignment operator combines the functionality of the addition operator *and* the assignment operator. For example, let's say that our favorite cat Maru has just had a birthday:

```ruby
adorable_cat = "Maru"
age = 7

# you've just had a birthday! add one year to your age:
age = 7 + 1
```

Let's take another look at our `age` variable and the operation of incrementing it by `1`:

```ruby
age = 7
# age starts at 7 and will get incremented after the birthday
age = age + 1
age #=> 8
```

Here, we have one variable, `age` which starts at `7`. Then, we reassign `age` to hold the original value of `age` plus `1`. `age + 1` is evaluated first, returning `8`, and then we are assigning the result of that expression (everything on the right of `age =`, which again is `age + 1`, which just means `8`), as the new value for `age`. We can make this even more elegant by using the add-and-assignment operator `+=` instead:

```ruby
age = 7
age += 1
age #=> 8
```

Here, `+=` serves the purpose of the above line: `age = age + 1`. It's simply condensing that action. It adds a numerical value (or other variable) to a numerical variable, and reassigns that variable to hold the sum of that variable's original value plus the added value (or other variable).

When we use `+=`, we call this action "incrementing". We are adding a new increment to a known value. Why is that useful? For looping.

Let's re-write our loop from earlier, this time using the `+=` operator:

```ruby
counter = 0

loop do 
  counter += 1
  puts "Iteration #{counter} of the loop"
  if counter >= 10 
    break
  end
end
```

If you copy this to IRB you'll see the same input as above:

```
Iteration 1 of the loop
Iteration 2 of the loop
Iteration 3 of the loop
Iteration 4 of the loop
Iteration 5 of the loop
Iteration 6 of the loop
Iteration 7 of the loop
Iteration 8 of the loop
Iteration 9 of the loop
Iteration 10 of the loop
```



<p data-visibility='hidden'>View <a href='https://learn.co/lessons/looping-readme' title='Looping'>Looping</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/looping-readme'>Loops</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/looping-readme'>Looping</a> on Learn.co and start learning to code for free.</p>
