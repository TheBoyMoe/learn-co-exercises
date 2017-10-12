# Classes And Instances

## Objectives

1. Describe a Ruby class and how it creates objects
2. Describe a Ruby instance 
3. Create an instance of a class

## Defining a Class

Let's say we are building a dog walking app. Our app's users might be dog walkers and dog owners and they can use the app to manage the dog walks. Such an app would need to store information about a potentially large number of dogs.

Our program needs to have a way to bundle up and operate on all the information about a particular dog. And, our program needs to be able to do this again and again. And, once more, we'll need our program to be able to create *new* bundles of information regarding individual dogs every time a new dog is added to the app.

How can we tell our Ruby program to deal with these dogs? Well, we can write a `Dog` class that produces individual dog objects, each of which contains all the information and behaviors of an individual dog.

Think of a class like the blueprint that defines how to build an object.  The `Dog` class is different from an individual dog just as the blueprints that show how to build a house are not the actual house. A Ruby class both contains the instructions for creating new objects and has the ability to create those objects. Calling `.new` on the `Dog` class is like getting a brand new dog object from an assembly line which produces a series of similar dog objects based on the same `Dog` template. 



Here's what our `Dog` class would look like:

```ruby
class Dog
  # some code to describe a dog
end
```

The `Dog` class is defined with the `class` keyword, followed by the class name and closed with an `end`. The body of this class is between the `class` and `end` keywords.  

Class names begin with capital letters because they are stored in Ruby constants. If your class name contains two words, the name should be CamelCased, like this:

```ruby
class MyClass
  # some code all about your awesome class
end
```

With this code alone, we can now make new dogs!

## Creating Instances of Classes

```ruby
class Dog
end

fido = Dog.new
fido #=> #<Dog:0x007fc52c2d7d20>
```

In the code sample above, once we've defined our `Dog` class with the `class` keyword, we immediately can bring to life new individual dogs, the variable `fido` which points to a new instance of a dog.

On the `Dog` class, we call the `.new` method and that will **instantiate** a new dog.

**Instantiate** means bringing a new object to life, a new individual, like a particular dog, like Snoopy or Lassie or Rover. Each particular dog is an individual that was **instantiated** when we called `Dog.new` to birth it into our world of programming.

We call these individuals, each specific dog or version of our class, **instances**. An **instance** is a single occurrence of an object. **Instances** refer to the individual objects produced from the class.

```ruby
class Dog
end

fido = Dog.new
fido #=> #<Dog:0x007fc52c2d7d20>

snoopy = Dog.new
snoopy #=> #<Dog:0x007fc52c2d4170>
```

`snoopy` and `fido` are two different variables pointing at separate instances of the `Dog` class.

### Different Instances are Different Objects

Let's make three dogs:

```ruby
class Dog
end

fido = Dog.new
fido #=> #<Dog:0x007fc52c2d7d20>

snoopy = Dog.new
snoopy #=> #<Dog:0x007fc52c2d4170>

lassie = Dog.new
lassie #=> #<Dog:0x007fc52c2cc588>
```

Notice that every time you make an instance of a class, Ruby tells you that the return value is something that looks like `#<Dog:0x007fc52c2cc588>`. This syntax is called Ruby Object Notation and it's just the default way that Ruby communicates to you that you are dealing with an object or instance of a particular class. The `Dog:0x007fc52c2cc588` tells you that the object is an instance of `Dog` and the `0x007fc52c2cc588` is called its object identifier and it basically means this is where the object lives inside your computer.

Each of these instances are totally unique, even though they are all born from `Dog`.

```ruby
class Dog
end

fido = Dog.new
fido #=> #<Dog:0x007fc52c2d7d20>

snoopy = Dog.new
snoopy #=> #<Dog:0x007fc52c2d4170>

snoopy == fido #=> false - these dogs are not the same.
```

Classes are the blueprints that define the behavior and information our objects will contain. They let us manufacture and instantiate new instances.

<p class='util--hide'>View <a href='https://learn.co/lessons/ruby-intro-to-classes-and-instances'>Classes and Instances</a> on Learn.co and start learning to code for free.</p>
