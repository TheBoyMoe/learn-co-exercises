# Class Variables and Class Methods

## Objectives

1. Define a class variable. 
2. Define a class method. 
3. Understand why and when to use class variables and methods. 
4. Understand the scope of class variables and class methods. 

## Introduction: Classes are Objects Too

All objects are bundles of data and logic––or attributes and behavior. We understand this to be true of instances of a class. Each instance contains attributes or properties as well as methods that can enact behaviors. 

For example, let's say we have a class, `Album`. Every individual album instance should have a release date attribute. To accomplish this, we'll define an instance variable, `@release_date` and an instance method `#release_date` that exposes or reveals that variable. 

```ruby
class Album

  def release_date=(date)
    @release_date = date
  end
  
  def release_date
    @release_date
  end
end
```

Here we have an instance variable, `@release_date`, which can be set equal to a value using the `release_date=()` method, a setter method. Then, we have a getter method `release_date` that returns the value of `@release_date`. Now, we can execute the following:

```ruby
album = Album.new
album.release_date = 1991
album.release_date 
  # => 1991
```

What you might not know, however, is that the `Album` class itself is also an object. If our definition of an object is a bundle of code that contains attributes and behaviors, then the entire `Album` class itself absolutely qualifies. 

The `Album` class can have its own variables and methods. We call these class variables and class methods. 

## Why Use Class Variables and Methods

Let's say you wanted to keep a counter for how many albums you had in your music collection. That way, you can brag to your friends about what a music aficionado you are. The current code in our `Album` class has no way to keep such a count. Looks like we will have to write some code to accommodate this new feature of our program.

When it comes to adding new features or functionalities to our code, we start out by asking a question: whose responsibility is it to enact this behavior or functionality? 

Right now, our program is pretty simple. We have an `Album` class and we have album instances. So, is it the responsibility of an individual album to keep a count of all of the other albums? Or is it the responsibility of the `Album` class, which actually produces the individual albums, to keep a running count? I think we can agree that it *isn't* the job of the individual albums, but the job of the `Album` class to keep a count of all of instances it produces. 

Now that we've decided whose job it is to enact the "keep a count of all albums" behavior, we can talk about *how* we enact that behavior. 

We do so with the use of class variables and methods. Our goal is to be able to ask the `Album` class: "how many albums have you produced?" When we ask an object to tell us something about itself, we use methods. It would be great if we could do something like:

```ruby
Album.count
```

and return the number of existing albums. Let's build out this capability now. 

## Building Class Methods and Using Class Variables

An instance variable is responsible for holding information regarding an instance of a class and is accessible only to that instance of the class. A class variable is accessible to the entire class––it has **class scope**. A class method is a method that is called on the class itself, not on the instances of that class. Class variables store information regarding the class as a whole and class methods enact behaviors that belong to the whole class, not just to individual instances of that class. 

### Defining a class variable

A class variable looks like this: `@@variable_name`. Just like an instance or a local variable, you can set it equal to any type of data. 

Let's create a class variable, `@@album_count` and set it equal to `0`. 

```ruby
class Album

  @@album_count = 0

  def release_date=(date)
    @release_date = date
  end
  
  def release_date
    @release_date
  end
end
```

Great, now we have a class variable to store our count of albums in. We can't yet access that variable from outside of our class though. How can we expose the contents of that variable? With a class method. 

### Defining a class method

A class method is defined like this:

```ruby
def self.class_method_name
  # some code
end
```

Here, the `self` keyword refers to the entire class itself, *not to an instance of the class*. In this case, we are inside the class only, not inside an instance method of that class. So, we are in the class scope, not the instance scope. 

Let's define a class method `.count` that returns the current count of albums. 

```ruby
class Album
  @@album_count = 0
  
  def self.count
    @@album_count
  end
end
```

Great, now if we call:

```ruby
Album.count
```

It will return `0`. 

### Operating on a class variable inside an instance method

Currently, however, our `@@album_count` is stuck at `0`. When and how should we increment it? The count of albums should go up as soon as a new album is created, or initialized. We can hook into this moment in time in our `#initialize` method. 

```ruby
class Album
  @@album_count = 0 
  
  def initialize
    @@album_count += 1
  end
  
  def self.count
    @@album_count
  end
end
```

Here we are using the `@@album_count` class variable, inside of our `#initialize` method, which is an instance method. We are saying: when a new album is created, access the `@@album_count` class variable and increment its value by 1. 

We can access our class variables anywhere in our class: in both class and instance methods. 

Now our code should behave in the following manner:

```ruby
Album.new
Album.new
Album.new

Album.count
  # => 3
```
