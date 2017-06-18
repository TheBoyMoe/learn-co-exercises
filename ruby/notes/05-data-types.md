# Data Types

## Overview

This lesson will introduce you to the six data types in Ruby. Just like the English language has different types of data or ways of representing information––words, numbers, lists, etc––Ruby has several different data types, which are also known as classes. (Ruby has several classes built in, but you'll learn how to make your own classes later on.)

## Objectives

1. Identify and construct the six data types in Ruby: booleans, symbols, numbers, strings, arrays, and hashes
2. Distinguish between the literal and class constructor when creating strings, arrays, and hashes
3. Perform basic operations on data types

## Video

<iframe width="853" height="480" src="https://www.youtube.com/embed/iaz3dojT9ew?rel=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

## Strings

### What is a String?

A string is a data type that represents textual data. In Ruby, a string is a sequence of characters enclosed in double or single quotes.

For example:

```ruby
"hello"
```

`"hello"` is a string!

The above string is an instance of Ruby's String class. In other words, the `"hello"` string is made based on the String template that is a part of Ruby. This means that every string we make has certain behaviors or attributes, just by virtue of it being a string.

### Creating Strings

There are two ways to create a string. In fact, we've already created a string just by typing `"hello"`.

Try it out by opening up IRB, and typing `"hello".class`

You should see a return value of ` => String `. You can actually call `.class` on any object to find out what type of data, i.e. what class, it is.

**The Literal Constructor:** This is the method through which we created our "hello" string.

**The Class Constructor:** You can also create a string with `String.new`. This will create an empty string.

`String.new("hello")` on the other hand, will create this string: `"hello"`. For the most part, you will create strings using the first method discussed here––simply by enclosing whatever text you want in quotes.

### Operating on Strings

Because every string is an instance of, or is based on, Ruby's String class, there are certain behaviors, or methods, available to us for operating on them. You can learn more about the many String methods by reading the [Ruby documentation](http://ruby-doc.org/core-2.2.0/String.html) on Strings. For now, we'll just take a look at a few examples.

```ruby
"hello".size
   => 5
"hello".upcase
   => "HELLO"
"hello".reverse
   => "olleh"
```

## Booleans

There are only two values of the Boolean data type: `true` and `false`. In Ruby, however, there is no such thing as a Boolean class. Instead, every appearance, or instance, of `true` and `false` in your program are instances of TrueClass and FalseClass respectively.

### Creating Booleans

Unlike strings, there is not a way to create a Boolean value, other than to explicitly write `true` or `false`. Later, we will see that we can write lines of code that *evaluate to* or return `true` and `false`, but we won't worry about that for now. 	

### Operating on Booleans

We don't!

## Numbers

You probably already know from the real world (as opposed to the Ruby world) that integers are numbers. In Ruby, there are two types of numbers: Fixnums and Floats.

**Fixnums** are whole numbers, like `7`.

**Floats** are decimal numbers, like `7.3`.

### Creating Integers

Once again, there is no special magic to creating integers. Simply declare them by typing `9000123` or `2`.

### Operating on Fixnums and Floats

There are a number of methods available to you for operating on or manipulating integers. You can read more about Fixnums [here](http://ruby-doc.org/core-2.2.0/Fixnum.html) and more about Floats [here](http://ruby-doc.org/core-2.2.0/Float.html). For now, we'll just check out a few examples:

```ruby
7.5.floor
  => this method will round the float down to the nearest fixnum. Here it will return 7

7.5.ceil
  => 8
10.next
  => 11
```

## Symbols

A symbol is a representation of a piece of data. Symbols look like this `:my_symbol`. If I make a symbol, `:my_symbol`, and then use that symbol later on in my code, my program will refer to the same area of memory in both cases. This is different from, for example, strings, which take up new areas of memory every time they are used.

### Creating Symbols

You write symbols by placing a `:` in front of the symbol name.

`:this_is_a_symbol`

The usefulness of symbols will become more apparent later on, so that's all on symbols for now.

## Arrays
Arrays are collections of Ruby objects. You can store any type of data in an array.

### Creating Arrays

There are a number of ways to create an array. Just like with creating strings, you can use the literal constructor or the class constructor.

**The Literal Constructor:**`[1, 3, 400, 7]` is an array of integers. Any set of comma separated data enclosed in brackets is an array. So, by simply writing something like the above, you can create an array.

**The Class Constructor:** You can also create an array with the [`Array.new` syntax](http://ruby-doc.org/core-2.2.0/Array.html). Just typing `Array.new` will create an empty array (`=> []`).

### Operating on Arrays

There are many ways to operate on arrays and on each individual item, or element, within an array. Later on in the course, we'll learn about iteration––the process of operating on each successive item in an array. For now, we'll preview a few array methods, and you can check out more [here](http://ruby-doc.org/core-2.2.0/Array.html).

```ruby
[5, 100, 234, 7, 2].sort

  => [2, 5, 7, 100, 234]

[1, 2, 3].reverse
  => [3, 2, 1]
```

## Hashes

Hashes also store objects in Ruby. However, they differ from arrays in that they function like dictionaries. Instead of a simple comma separated list, hashes are composed of key/value pairs. Each key points to a specific value––just like a word and a definition in a regular dictionary.

Hashes look like this:
`{"i'm a key" => "i'm a value!", "key2" => "value2"}`

The curly brackets denote the hash and this particular hash has two key/value pairs.

### Creating Hashes

Hashes can be created with literal constructors and class constructors.

**The Literal Constructor:** You can create a hash by simply writing key/value pairs enclosed in curly braces.

**The Class Constructor:** Or, you can use the [`Hash.new` syntax](http://ruby-doc.org/core-2.2.0/Hash.html), which would create an empty hash, `{}`.

### Operating on Hashes

There are many methods for operating on hashes and their individual key/value pairs. We will learn much more about them later, but you can preview some methods [here](http://ruby-doc.org/core-2.2.0/Hash.html).

## Resources
* [RailsBridge](http://docs.railsbridge.org) - [Data Types](http://docs.railsbridge.org/ruby/datatypes)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/data-types-readme' title='Data Types'>Data Types</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/data-types-readme'>Ruby Data Types</a> on Learn.co and start learning to code for free.</p>
