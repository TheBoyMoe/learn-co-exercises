## Classes and Inheritance

```ruby
  class DerivedClass < Base
    def some_method
      super(optional args)
        # Some stuff
      end
    end
  end
```

When you call super from inside a method, that tells Ruby to look in the superclass of the current class and find a method with the same name as the one from which super is called. If it finds it, Ruby will use the superclass' version of the method. If that method takes any arguments, pass them to super.


```ruby
  class Creature
    def initialize(name)
      @name = name
    end

    def fight
      return "Punch to the chops!"
    end
  end

  # Add your code below!
  class Dragon < Creature
    def fight
      puts "#{super}, Breathes fire!"
    end
  end

  dragon =  Dragon.new
  puts dragon.fight # => "Punch to the chops!, , Breathes fire!"
```

```ruby
  class Message
    @@messages_sent = 0

    def initialize(from, to)
      @from = from
      @to = to
      @@messages_sent += 1
    end

    # because @messages_sent is a class variable, we need a class method to access it
    def self.messages_sent
      @@messages_sent
    end
  end

  class Email < Message
    def initialize(from, to)
      super(from, to)
    end
  end

  my_message = Email.new('John', 'Harry')
```

Any given Ruby class can have only one superclass. Some languages allow a class to have more than one parent, which is a model called multiple inheritance. However, there are instances where you want to incorporate data or behavior from several classes into a single class, and Ruby allows this through the use of mixins.


## Classes and Public/Private Methods

Methods are public by default in Ruby, so if you don't specify public or private, your methods will be public. However, we can make it clear to people reading our code which methods are public. We do this by putting public before our method definitions, like so:

```ruby
  class ClassName
    # Some class stuff
    public
      def public_method
        # public_method stuff
      end
  end
```

Note that everything after the `public` keyword through the end of the class definition will now be public unless we say otherwise. We use the `private` keyword to define private methods. Private methods are just that: they're private to the object where they are defined. This means you can only call these methods from other code inside the object. Another way to say this is that the method cannot be called with an explicit receiver. You've been using receivers all along—these are the objects on which methods are called! Whenever you call object.method, object is the receiver of the method.

In order to access private information, we have to create public methods that know how to get it. This separates the private implementation from the public interface.
