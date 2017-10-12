# The `while` and `until` Constructs

## Objectives

1. Describe the `while` construct and how it implements looping
2. Describe the `until` looping construct 

## `while`

The `while` construct is a little different from the loop construct that we looked at earlier. The `while` construct will keep executing a block as long as a specific condition is `true`.

Let's look at a long and repetitiously-counting code that uses `if` statements to count from `0` to `20`? Well, we can refactor that into simple, readable, *short* code with the `while` construct:

```ruby
counter = 0
while counter < 20
  puts "The current number is less than 20."
  counter += 1
end
```

Think about the above code like this:

*  While it is true that the variable `counter` is set to a value that is less than `20`, execute the code in the block.
*  Inside the block, `puts` a phrase, and increment the counter by one.
*  Go back to the top! Check to see if the `counter` is less than `20`. If it is true that the value is less than `20`, go back into the block. Otherwise, break out of the loop and don't execute the code inside the loop.

We can achieve all of that with just a few lines of code utilizing a `while` construct. Go ahead and copy and paste the above code in irb. 

## Examples

### Basic `while` Example: Hot Dog Eating Contest

Let's say you are a world famous competitive eater participating in the Coney Island Nathan's Hot Dog Eating Contest in Brooklyn, NY. You're kind of new to the competitive eating game though, so you only have the capacity for seven (7) hot dogs.


```ruby
num_of_hotdogs_eaten = 0
# => 0 (return value)

while num_of_hotdogs_eaten < 7
  num_of_hotdogs_eaten += 1
  puts "You have now eaten #{num_of_hotdogs_eaten} hot dog(s)."
end
# => nil (return value)

puts "You ate a total of #{num_of_hotdogs_eaten} hot dogs!"
# => nil (return value)

# > "You have now eaten 1 hot dog(s)."
# > "You have now eaten 2 hot dog(s)."
# > "You have now eaten 3 hot dog(s)."
# > "You have now eaten 4 hot dog(s)."
# > "You have now eaten 5 hot dog(s)."
# > "You have now eaten 6 hot dog(s)."
# > "You have now eaten 7 hot dog(s)."

# > "You ate a total of 7 hot dogs!"

```

## `until`

`Until` is simply the inverse of a `while` loop. An `until` keyword will keep executing a block *until a specific condition is true*. In other words, the block of code following `until` will execute while the condition is false. One helpful way to think about it is to read `until` as "if not".

```ruby
counter = 0
until counter == 20
  puts "The current number is less than 20."
  counter += 1
end
```

* The counter once again starts at `0`. If it is *not* true that the counter is equal to `20`, the program will execute the code in the block.
* Inside the block, we will `puts` a phrase and increment the counter by `1`.
* Then, the program will go back to the top of the `until` loop and once again check to see if the counter is equal to `20`. If it is *not* true that the counter is equal to `20`, then the program will continue executing the code in the block. Otherwise, the program will break out of the loop.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/while-and-until-looping-readme' title='The while and until Constructs'>The while and until Constructs</a> on Learn.co and start learning to code for free.</p>
