## Statement Modifiers
Ruby has a useful feature called a statement modifier that allows you to put a conditional at the end of a statement. For example, let's consider this statement:

```ruby
puts "Hey, it's 2015!"
``` 

However, we don't want to say "Hey, it's 2015!" every time this code is run. We only want to say it's 2015 if it's actually 2015. This is a good case for an `if` statement modifier.

```ruby
this_year = Time.now.year
puts "Hey, it's 2015!" if this_year == 2015
``` 
Now, with the statement modifier `if this_year == 2015` we are only putting it if the year is, in fact, 2015.

We can also use `unless` in a statement modifier as well. 

```ruby
this_year = Time.now.year
puts "Hey, it's not 2015!" unless this_year == 2015
``` 


## Case Statement

The `case` statement will allow us to run multiple conditions against the same value, meaning that we can check the `name` variable against a variety of conditions without repeating our use of the comparative operator (`==`) in each one.


```ruby
case name 

  when "Alice"
    puts "Hello, Alice!"
  when "The White Rabbit"
    puts "Don't be late, White Rabbit"
  when "The Mad Hatter"
    puts "Welcome to the tea party, Mad Hatter"
  when "The Queen of Hearts"
    puts "Please don't chop off my head!"
  else 
    puts "Whoooo are you?"
end
```

### Writing a `case` Statement

Now that we understand *when* to use a `case` statement in place of a series of `if` and `elsif` statements, let's look at *how* to build a `case` statement from scratch. 

#### Step 1: Create a Value

A case statement starts with the `case` keyword followed by a value to test.

```ruby
case greeting
# ...
end
```

#### Step 2: Create the Conditions

Next, the `when` keyword is followed by a condition.

```ruby
case greeting
  when "unfriendly_greeting"
    #...
  when "friendly_greeting"
    #...
end
```

#### Step 3: Add the Code

The functionality that we wish to happen when the condition is met is placed on an indented line directly under the `when` line. Let's define the behavior:

```ruby
greeting = "friendly_greeting"

case greeting
  when "unfriendly_greeting"
    puts "What do you want!?"
  when "friendly_greeting"
    puts "Hi! How are you?"
end
```

##### Advanced: How does it work?

Under the hood, `case` statements actually evaluate their `when` conditionals by implicitly using the "case equality operator"; the case equality operator is otherwise represented by `===` ("threequals") sign. While `case` can be used to replace the comparison operator in a situation like the first example in this reading, it's doing something slightly different. [Read more about === here.](http://stackoverflow.com/questions/3422223/vs-in-ruby?lq=1)

Similar to the comparison operations above, the `when` statement evaluates to a boolean value by using the `case` value at the start of the `case` statement and the value following the `when` keyword. If this `when` condition evaluates to `false`, then the indented code beneath that condition is skipped; if it evaluates to `true`, then the indented code beneath it is executed.

In the above case, Ruby compares the `case` value to the two `when` conditions; `"friendly_greeting" === "unfriendly_greeting"` is `false`, so `puts "What do you want!?"` is *not* run; however, `"friendly_greeting" === "friendly_greeting"` is `true`, so `puts "Hi! How are you?"` *is* run.

It is not necessary at this point to understand the distinction between the comparative operator (`==`) and the case comparison operator (`===`). Just realize that there *is* a distinction, even though the usages relevant to you right now will be similar.

##### Examples:

```ruby
print "Enter your grade: "
grade = gets.chomp

case grade
  when "A"
    puts "Good job, Homestar!"
  when "B"
    puts "You can totally do better!"
  when "C"
    puts "Find a mentor to help you!"
  else
    puts "You're just making that up!"
end
```


```ruby
grade = 95

case grade
  when 90..100 then "A" 
  when 80..90 then "B"
  when 70..80 then "C"
  when 60..70 then "D"
  when 0..60 then "F"
end
```