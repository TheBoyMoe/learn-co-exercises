# Ruby Symbols
## Overview
We'll discuss a new data type, the symbol, and why they're useful as hash keys.

## Objectives

1. Describe the syntax of symbols.
2. Explain how symbols are immutable objects.
3. Explain why symbols are useful as hash keys because of their immutability.

## What is a Symbol?

Let's look at the example below:

```
:i_am_a_symbol
```

Note that the keyword above starts with a colon (`:`). That isn't just convention; the keyword here is a special type of object called a "symbol". A symbol is similar to a string, but with one primary distinction: a symbol can't be changed.

To put it another way, symbols are unique. This is the reason we use them as keys for hashes. Let's take a closer look at the differences.

##Difference between a symbol and a string

###Strings are Mutable

Strings are *mutable*, meaning that we can manipulate them in various ways by adding, removing, or replacing characters. For example, it is perfectly reasonable to change 'Steven' to 'Steve' in Ruby.

```ruby
"Steven".chomp("n")
  #=> "Steve"
```

Ruby accounts for that possible mutability by allocating more memory for it. Every time you create a string, *it creates a new object in memory*, even if the string text is identical to another one you've already created. Ruby has to store each of them separately because any one of them may change in the future. We can test this by asking an object for its `object_id`—a handle that Ruby uses to track it in memory.

Drop into `IRB` in your terminal to play around with the following code:

```ruby
name = "Steven"
same_as_name = "Steven"

name.object_id == same_as_name.object_id
  #=> false

# Stored in 2 different locations in memory
```

Try printing out the `object_id` of an identical string a couple times to see that they are, in fact, different. Note: your `object_id` will be different from the ones below. The important thing to note is that none of them will be the same id.

```ruby
puts "Steven".object_id
puts "Steven".object_id
puts "Steven".object_id

# > 70236825545220
# > 70236822108160
# > 70236821810060
```

###Symbols are Immutable

The symbol, however, is **immutable**. This means that its state can't be modified after it is created and it will always be the same size in memory. Unlike the string, the same symbol can be referenced many times. If you have multiple references to one symbol, all of those references will always point to the same object. You can verify this yourself in IRB:

``` ruby
name = :steven
same_as_name = :steven
name.object_id == same_as_name.object_id
  #=> true
```

Try printing out the `object_id` for the symbol `:Steven` the same way we did for the strings above. This time we should see the exact same id no matter how many times we run the code. Again, the specific id will differ on your machine.

```ruby
puts :steven.object_id
puts :steven.object_id
puts :steven.object_id

# > 1093988
# > 1093988
# > 1093988
```

## Why Use Symbols as Hash Keys?

Since all copies of `:steven` have the same object_id, they use up less memory! `"Steven"` uses a new slot of memory each time you create it. `:steven` does not. This is because keys do not need to be mutable. Since they don't need to be mutable, and since mutable objects like strings take up more space in memory, we use immutable, memory-saving symbols as hash keys.

### A Note about Ruby Versions >= 1.9

You've probably seen Ruby hashes written with the hash-rocket (`=>`) notation:

```ruby
flatiron_school = {:instructor => "Isaac Newton"}
```

In Ruby 1.9, we were introduced with the option of forgoing the hash-rocket (`=>`) when writing key/value pairs when the key is a symbol. Instead we can express it like this:

```ruby
flatiron_school = {instructor: "Isaac Newton"}
```

A key expressed like `instructor:` is still interpreted as a symbol by the interpreter and this syntax is understood in the same way as a hash-rocket when the program is run.

You can use either syntax; however, be consistent with whichever one you choose. We generally recommend the `instructor:` style.
