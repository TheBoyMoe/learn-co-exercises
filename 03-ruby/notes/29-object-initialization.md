# Instantiating with `#initialize`

## Objectives
1. What is the `#initialize` method?
2. How does it work?
3. What do we use it for?

## Instantiating Instances of Classes

We've already seen new instances of classes being created with the `#new` method. For example:

```ruby
class Dog
end

snoopy = Dog.new #=> #<Dog:0x007f970a2edfd0>
```

The code above creates a new instance of the `Dog` class and sets that object equal to a variable, `snoopy`. If we want to give our dog a breed, we have to use the following code:

```ruby
class Dog
  def breed=(breed)
    @breed = breed
  end

  def breed
    @breed
  end
end

snoopy = Dog.new #=> #<Dog:0x007f970a2edfd0>
snoopy.breed #=> nil
snoopy.breed = "Beagle"
snoopy.breed #=> "Beagle"
```

However, most dogs are born *with* a breed, not assigned a breed afterwards. How can we model the behavior of dogs being born with a breed in our `Dog` class? If only there was a way for us to assign an individual dog a breed automatically upon creation, or instantiation.

Lucky for us, there is! It's called the `#initialize` method.

## The `#initialize` Method

We already know that any Ruby class can produce new instances of itself, via the `<Class Name>.new` method, whether or not that class has an `#initialize` method. However, if we want each instance of our class to be created with certain attributes, we must define an `#initialize` method. An `#initialize` method is a method that is called automatically whenever `#new` is used.

Let's define an `#initialize` method that takes in an argument of a dog's breed and sets a `@breed` variable equal to that argument. In other words, let's define our `#initialize` method to contain the functionality of the `#breed=` method, so that a dog instance will get a breed assigned to it right away when it is created, without us having to explicitly use the `#breed=` method.

### Defining an `#initialize` method

```ruby
class Dog
  def initialize(breed)
    @breed = breed
  end

  def breed=(breed)
    @breed = breed
  end

  def breed
    @breed
  end
end
```

Now, we can call `#new` like this:

```ruby
lassie = Dog.new("Collie")

lassie.breed #=> "Collie"
```

### How does it work?

When `#new` is called with an argument, it will pass that argument (or arguments) to the `#initialize` method and invoke that method. The code in `#initialize` will then run, using any arguments from `#new`.

The initialize method is what's called a callback method, because it is automatically invoked every time the `#new` method is used to create a new instance of the class.

You can also think of the initialize method as a constructor method. A constructor method is invoked upon the creation of an instance of a class and used to help define the instance of that class.

So, because of how we defined our initialize method, every time you type `Dog.new("some breed")`, a new dog instance is created that has a breed of "some breed" (i.e. whatever string you give the `#new` method).

## Resources 

* [Video Review- Intro to OO](https://www.youtube.com/watch?v=UysgBTrJoTc)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-initialization'>Object Initialization</a> on Learn.co and start learning to code for free.</p>
