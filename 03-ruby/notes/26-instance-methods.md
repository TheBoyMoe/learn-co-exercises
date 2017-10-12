# Instance Methods Ruby

## Objectives

1. Describe an instance method.
2. Call instance methods on an object.
3. Build instance methods for an object.

## The Behavior of Objects

We know that classes act as a factory for our objects, capable of instantiating new instances.

```ruby
class Dog
end

fido = Dog.new #=> #<Dog:0x007fc52c2cc588>
```

But what can this instance of a dog stored in the local variable `fido` do? In fact, how do we even ask this object to do something?

### Dot Notation

We send objects messages asking them to perform an operation or task through a syntax known as "Dot Notation".

```ruby
class Dog
end

fido = Dog.new #=> #<Dog:0x007fc52c2cc588>

fido.object_id #=> 70173135795280
```

In the example above, we send the `fido` instance a message `object_id` by separating the receiving object, `fido` and the message, `object_id` by a dot (`.`). When we send an object a message through dot notation, we are evoking the corresponding method on the object. We are calling the `object_id` method on `fido`. (Note: the `object_id` you get if you test out the above code will be different.)

The `#object_id` method simply tells you the object's identifier in your computer's memory (the place where all things live in your computer).

> I thought of objects being like biological cells and/or individual computers on a network, only able to communicate with messages. - Alan Kay

In dot notation, we call the object that received the method message the "receiver" and we call the method the "message".

```ruby
# The receiver is this very string      # reverse is the message
"Strings are instances and objects too".reverse
```

### Instance Methods

All objects respond to methods and messages, like `#object_id` in the example above. One interesting method provided is the `#methods` method that returns an array of all the methods and messages an object responds to. We can evoke this method via dot-notation. One of the great things you can ask every object in Ruby is "What methods do you respond to?"

```ruby
class Dog
end

fido = Dog.new
fido.methods
#=> [:psych_to_yaml, :to_yaml, :to_yaml_properties, :local_methods, :try, :nil?,
# :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup,
# :itself, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze,
# :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods,
# :private_methods, :public_methods, :instance_variables,
# :instance_variable_get, :instance_variable_set, :instance_variable_defined?,
# :remove_instance_variable, :instance_of?, :kind_of?, :is_a?, :tap, :send,
# :public_send, :respond_to?, :extend, :display, :method, :public_method,
# :singleton_method, :define_singleton_method, :object_id, :to_enum, :enum_for,
# :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__]
```

As you can see, out of the box, our objects can do a lot of things. Where these things come from and what they do are not so important right now because all of that functionality is very low level and not interesting to our Dogs.

### Building Your Own Instance Methods

How do we add our own methods to our classes? In our Dog example, can we teach our Dog a new trick? Can we teach our Dog to bark for example?

We can. We're used to defining methods already with the `def` keyword. If we place this method definition within the body of a class, that method becomes a specific behavior of instances of that class, not a generic procedure we can just call whenever we want.

We call the methods defined within the object's class **Instance Methods** because they are methods that belong to any instance of the class.

```ruby
class Dog
  # Class body

  # Instance Method Definition
  def bark
    puts "Woof!"
  end
end

fido = Dog.new
fido.bark #> "Woof!"
```

By defining `#bark` within the `Dog` class, `bark` becomes a method of all instances of Dogs. If we make more dogs, they can all bark.

```ruby
class Dog
  def bark
    puts "Woof!"
  end
end

fido = Dog.new
fido.bark #> "Woof!"

snoopy = Dog.new
snoopy.bark #> "Woof!"
```

Objects can only do what we teach them to do via the code we write and the methods we define. For example, currently, Dogs do not know how to sit.

```ruby
class Dog
  def bark
    puts "Woof!"
  end
end

fido = Dog.new
fido.bark #> "Woof!"
fido.sit # NoMethodError: undefined method `sit' for #<Dog:0x007fa4e9a9e8a0>
```

In the same manner, instance methods, the methods that belong to particular instances of particular classes, are not globally evocable like procedural methods. They cannot be called without an instance.

```ruby
class Dog
  def bark
    puts "Woof!"
  end
end

fido = Dog.new

# Let's try just calling bark without fido
bark # NameError: undefined local variable or method `bark' for main:Object
```

### Classes as Blueprints

The ability to define methods and behaviors in our classes for our instances makes Ruby classes behave not just as factories, capable of instantiating new individual instances, but also as a blueprint, defining what those instances can do.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/instance-methods-readme-ruby' title='Instance Methods Ruby'>Instance Methods Ruby</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/instance-methods-readme-ruby'>Instance Methods</a> on Learn.co and start learning to code for free.</p>
