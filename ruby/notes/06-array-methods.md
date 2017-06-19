# Introduction to Arrays

## Overview

This lesson will give a deeper dive on how to create, manipulate, and retrieve data from arrays.

## Objectives

1. Describe how arrays are useful in storing multiple pieces of information.
2. Create and populate an array.
3. Identify elements in an array based on their index.
4. Retrieve items from an array.
5. Assign new values to an array.
6. Add items to an array using different methods.
7. Remove items from an array using different methods.
8. Reference the Ruby documentation on arrays.

## What is an Array?

So far, we've used variables to store information. For example, I could create a variable called `my_name` and set it equal to my name: `my_name = "Severus Snape"`. However, variables only allow us to store one piece of information at a time.

What if my boss, Headmaster Dumbledore, asks me to deliver the names of all of my students? I could create a bunch of variables like this:

```ruby
student_1 = "Harry Potter"
student_2 = "Ron Weasley"
student_3 = "Hermione Granger"
student_4 = "Draco Malfoy"

# etc...
```

I could write a program that passes around these variables *one at a time*. This seems messy though. I could easily forget about a student, for example. Or need to create a new student and then have to hunt through my program for every place I ever passed around all of these individual variables.

If this was real life, Professor Snape would probably just write down all the students in list form and hand that list to Dumbledore. Well, in Ruby, we can do the same thing using an array.

An array is like a list but in code form. It is a way for your program to store pieces of data as a *collection*. Arrays can contain any data types in any combination––strings, integers, other arrays, hashes, etc.

Arrays are declared by listing variable names or literals separated by commas (`,`) and wrapped in square brackets `[ ]`. To save our four students from above into an array, we write that in our code like this:

```ruby
students = ["Harry Potter", "Ron Weasley", "Hermione Granger", "Draco Malfoy"]
```

## Creating an Array

There are a few different ways to make a new array. You can use the literal constructor or the class constructor.

##### The Literal Constructor

```ruby
my_array = []
```

##### The Class Constructor

```ruby
my_array = Array.new #=> []
```

**Advanced:** A class is like a template, or blueprint, for creating objects in Ruby. An "object" is simply a bundle of information and behaviors. For example, a string is an object, because it contains information (i.e. the text inside the `" "`) and because it has behaviors––it can do things/have things done to it. For example:

```ruby
"hi".reverse #=> "ih"
```

There is an Array class that serves as the blueprint for every array that you will make. This means that all arrays are capable of certain shared behaviors and are responsive to certain methods.

To create a new array object from the Array class, you can call `.new` on `Array` – the name of the class. This creates a brand new, empty array. Don't worry about understanding objects and classes, or the `.new` method, just yet. They are all part of something called Object Oriented Programming, which is a big topic. We'll be building up to it through this and the next few units.

To make an array that isn't empty, you can separate each item, known as an element, by a `,` ("comma") and wrap all the elements inside `[ ]` ("square brackets").

```ruby
puppies = ["bulldog", "terrier", "poodle"]
# => ["bulldog", "terrier", "poodle"]

random_numbers = [ 2, 5, 6, 8, 30050]
# => [ 2, 5, 6, 8, 30050]

mixed = ["this", "array", 7, 20, "has", 45, "integers", "&", "strings", 309]
# => ["this", "array", 7, 20, "has", 45, "integers", "&", "strings", 309]
```

It is possible to create an array that contains disparate data types, but that is generally discouraged. It's best to keep your arrays populated with only one kind of element.

## Retrieving Items from Array

When you write out a list on a notepad, you typically write each item on its own line. Whether or not the list is explicitly numbered, the list has a numerical order to it based on the sequence of the lines that the items are listed upon.

Just like the items in our notepad lists, elements in an array are associated with a number that represents their order. In programming, this number is called an **index**. While humans typically start their lists at "1.", arrays begin their indexes at `0` (zero). So, the first item in array will always be "at index `0`". If we have an array of famous (fictional) cats:

```ruby
famous_cats = ["Cheshire Cat", "Puss in Boots", "Garfield"]
```

The `"Cheshire Cat"` is at index `0` in the array, `"Puss in Boots"` is  at index `1`, and `"Garfield"` is at index `2`. Indexes will always be *one less* than the **count**.

To access one of these items in the `famous_cats` array, we can type the name of the array immediately followed by the relevant index number wrapped in square brackets (`[ ]`).

```ruby
famous_cats =  ["Cheshire Cat", "Puss in Boots", "Garfield"]

famous_cats[1]  #=> "Puss in Boots"

famous_cats[0] #=> "Cheshire Cat"

famous_cats[2] #=> "Garfield"

famous_cats[20] #=> nil
```

## Assigning New Values to an Array

Now that we know how to create an array with literal constructors `[ ]` and read values out of an array via the index of the element like `["Red", "Yellow", "Green"][0]` for "Red", we should learn how to re-assign a value to an index in an array.

```ruby
speed_dial = ["Ada", "Kay", "Matz", "DHH", "Borg"]
```

We have five of our favorite friends in an array referenced by the local variable `speed_dial`. If we wanted to get the name of the person in the third position of our speed dial, we would call `speed_dial[2]` and it would return `"Matz"`.

But what about replacing someone in our speed dial? How could we replace "Kay" in index `1` of `speed_dial` with our new second favorite friend, `"Chipps"`?

To re-assign a value to an index in an array we use the `[ ]=` syntax. We must supply an index we want to re-assign and then a value for that index. For example:

```ruby
speed_dial = ["Ada", "Kay", "Matz", "DHH", "Borg"]
speed_dial[1] #=> "Kay"

speed_dial[1] = "Chipps"
speed_dial[1] #=> "Chipps"
```

Re-assigning a value to an index of an array looks a lot like variable definition and that is by design. Just indicate which index you want to write to with `[ ]`, and then assign it a new value with `=`. The old value is totally forgotten and replaced by the new value.

## Manipulating Arrays

If an array is a storage container for a list of data, then we can add and remove individual items from it. There are several ways to accomplish either.

### Adding Items to an Array

#### Shovel Method

The shovel method employs the "shovel" operator `<<` and allows you to add ("shovel") items onto the **end** of an array:

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]

famous_cats << "nala cat"

famous_cats #=> ["lil' bub", "grumpy cat", "Maru", "nala cat"]
```

The shovel method `<<` is the preferred syntax for adding elements to an array, however you might see other methods used in examples online:

#### The `.push` Method

Calling `.push` on an array with an argument of the element you wish to add to that array, will also add that element to the **end** of the array. It has the same effect as the shovel method explained above. However the `.push`  will also let you add multiple elements to an array, whereas the shovel method will only add one element.

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]

famous_cats.push("nala cat")

famous_cats #=> ["lil' bub", "grumpy cat", "Maru", "nala cat"]
```

#### The `.unshift` Method

To add an element to the *front* of an array, you can call the `.unshift` method on it with an argument of the element you wish to add:

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]

famous_cats.unshift("nala cat")

famous_cats.inspect #=> ["nala cat", "lil' bub", "grumpy cat", "Maru"]
```

### Removing Items From an Array

#### The `.pop` Method

Calling `.pop` on an array will remove the *last* item from the *end* of the array. The `.pop` method will also supply the removed element as its return:

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]
maru_cat = famous_cats.pop

famous_cats #=> ["lil' bub", "grumpy cat"]
maru_cat #=> Maru
```

#### The `.shift` Method

Calling `.shift` on an array will remove the *first* item from the *front* of the array. The `.shift` method will also supply the removed element as a return:

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]
lil_bub = famous_cats.shift

famous_cats #=> ["grumpy cat", "Maru"]
lil_bub #=> lil' bub
```

### Operating on Arrays

There are a number of other methods available for manipulating arrays. You can learn more about them [here](http://ruby-doc.org/core-2.2.0/Array.html), but we'll look at just a few examples together.

#### The `.reverse` Method

This method reverses an array.

```ruby  
famous_wizards = ["Dumbledore", "Gandalf", "Merlin"]

famous_wizards.reverse #=> ["Merlin", "Gandalf", "Dumbledore"]
```

#### The `.include?` Method

This method will return a boolean of whether or not the array contains (or *includes*) the element submitted to it inside the parentheses:

```ruby
famous_cats = ["lil' bub", "grumpy cat", "Maru"]

famous_cats.include?("Garfield") #=> false

famous_cats.include?("Maru") #=> true
```

## Additional Resources
* [Arrays on CodeAcademy](https://www.codecademy.com/courses/ruby-beginner-en-F3loB/0/1?curriculum_id=5059f8619189a5000201fbcb)
* [Ruby Arrays on Zet Code](http://zetcode.com/lang/rubytutorial/arrays/)
* [Ruby Arrays on Tutorials Point](http://www.tutorialspoint.com/ruby/ruby_arrays.htm)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/array-readme-qualifying' title='Introduction to Arrays'>Introduction to Arrays</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/array-readme-qualifying'>Array Basics</a> on Learn.co and start learning to code for free.</p>
