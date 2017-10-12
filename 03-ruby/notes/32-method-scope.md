# Method Scope

## Overview

In this lesson, we'll introduce the concepts of method scope and variable scope. 

## Objectives

1. Explain how scope prevents you from accidentally overwriting previous work.
2. Differentiate between the functionality of local variables created inside and outside of methods. 
3. Define methods that pass variables in as arguments.


## Variable Names and Scope 

Naming variables is hard, but it is important. We need our code to be as descriptive as possible. Any other developer reading over one of our programs should be able to understand what our code does. A big part of this is having variable (and method) names that are sensible and descriptive. 

Our variable names should be descriptive of what they hold, but they should also be concise. This can be difficult to achieve. You might even be worrying that you'll run out of unique, descriptive and concise variable names. Don't worry though, all programming languages have what is called **scope**. Scope means that not all variables exist everywhere in a program. If they did, then a variable that you'd be writing in file A could accidentally overwrite a variable made by your friend in file B. Having a scope for variables allows you to have greater confidence that you aren't overwriting someone else's work when you create variables.

## What is Scope?

Methods in ruby create their own scope. "Scope" refers to the areas of your program in which certain data is available to you. **Any local variable created outside of a method will be unavailable inside of a method. In addition, local variables created inside of a method (i.e. in between the `def` and `end` keywords of a method) 'fall out of scope' once you're outside the method.**

Let's take a look at the following example:

```ruby
name = "Joe"

def greeting(name)
   puts "Hello, #{name}"
end
```

In this code snippet, we have a variable, `name`, set equal to a string, `"Joe"`. Then we define a method, `#greeting`,  that takes in an argument of name. Are the `name` variable that is set equal to `"Joe"` and the `name` variable we are using as a parameter (or argument) for our `#greeting` method definition the same? Let's see. 

If we call our greeting method in the following way:

```ruby
greeting("Sophie")
```

What do we expect to be outputted to the terminal?

In this case, the above method invocation would `puts` out `Hello, Sophie` to the terminal. It is true that we are setting a variable, `name`, equal to `"Joe"` in this code snippet. But we are not using *that* variable anywhere else in our code. The `name` argument of the `#greeting` method is just a placeholder. It means: when we call the `#greeting` method with an argument of, say, `"Sophie"`, set the variable `name` *inside of the method* equal to that string argument. 

The `name` variable inside of the `#greeting` method is different from the `name` variable that we set equal to `"Joe"` outside of the method. The `#greeting` method has its own scope, and variables inside of it don't know about variables outside of it and vice versa. 

## Method Scope in Ruby

Think of a method as a castle. The `def` and `end` keywords are like the gates that keep out the barbarian hordes, dragons, etc. Let's take a look:

```ruby
evil_monster = "Bowser"

def princess_peaches_castle
  puts "#{evil_monster} is trying to kidnap Princess Peach!"
end
```

We've defined the variable `evil_monster` *outside* of the method, `princess_peaches_castle`. Then, we try to call on the `evil_monster` variable inside that method. Watch what happens when we invoke the method:

```ruby
princess_peaches_castle
# > NameError: undefined local variable or method `evil_monster' for main:Object
```

The `evil_monster` variable is out of scope for this method. The method can't access it **unless we pass it in as an argument**.

If we define our method to accept an argument, we can pass our variable into the method and the method will be able to operate on/use that variable. Let's take a look:

```ruby
evil_monster = "Bowser"

def princess_peaches_castle(evil_monster)
  puts "#{evil_monster} is trying to kidnap Princess Peach!"
end

princess_peaches_castle(evil_monster)
# > "Bowser is trying to kidnap Princess Peach!"

```

And now Mario can start his adventure.

So far, we've seen that variables defined outside of methods are not available inside methods (unless we pass them in as arguments). This works the other way around as well: variables defined inside of methods are not available outside of those methods. Let's take a look. 

If we define the following method to include a local variable:

```ruby
def practicing_method_scope
  im_trapped_in_the_method = "You can't access me outside this method!"
end
```

Trying to access that variable elsewhere in our program, *outside of this method*, will raise the following error:

```ruby
im_trapped_in_the_method
#=> NameError: undefined local variable or method `im_trapped_in_the_method' for main:Object
```

## Conclusion

Remember: A variable defined inside a method can't leave that method. It is not available to your program outside of the method. A variable defined outside of a method can only be made available to the code inside the method if you pass that variable in to the method as an argument. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/method-scope' title='Method Scope'>Method Scope</a> on Learn.co and start learning to code for free.</p>