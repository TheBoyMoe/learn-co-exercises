## Procs

Blocks are not objects, and this is one of the very few exceptions to the "everything is an object" rule in Ruby.

Because of this, blocks can't be saved to variables and don't have all the powers and abilities of a real object. For that, we'll need... procs!

You can think of a proc as a "saved" block: just like you can give a bit of code a name and turn it into a method, you can name a block and turn it into a proc. Procs are great for keeping your code DRY, which stands for Don't Repeat Yourself. With blocks, you have to write your code out each time you need it; with a proc, you write your code once and can use it many times!

The & is used to convert the proc into a block (since .collect! and .map! normally take a block). We'll do this any time we pass a proc to a method that expects a block.

```ruby
  multiples_of_3 = Proc.new do |n|
    n % 3 == 0
  end

  print (1..100).select(&multiples_of_3)
```

```ruby
  cube = Proc.new { |x| x ** 3 }
  [1, 2, 3].collect!(&cube)
  # ==> [1, 8, 27]
  [4, 5, 6].map!(&cube)
  # ==> [64, 125, 216]
```

```ruby
  floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
  # Write your code below this line!
  round_down = Proc.new {|v| v.floor}


  # Write your code above this line!
  ints = floats.collect(&round_down)
  print ints
```

Why bother saving our blocks as procs? There are two main advantages:

Procs are full-fledged objects, so they have all the powers and abilities of objects. (Blocks do not.)
Unlike blocks, procs can be called over and over without rewriting them. This prevents you from having to retype the contents of your block every time you need to execute a particular bit of code.

We can call procs directly by using Ruby's .call method.

```ruby
  test = Proc.new { # does something }
  test.call
  # does that something!
```


## Lambdas

Like procs, lambdas are objects. The similarities don't stop there: with the exception of a bit of syntax and a few behavioral quirks, lambdas are identical to procs.


```ruby
  lambda { puts "Hello!" }

  # is the same as

  Proc.new { puts "Hello!"}
```

```ruby
  #  pass the lambda to lambda_demo, the method calls the lambda and executes its code.
  # you can assign a lambda to a variable just like a Proc
  def lambda_demo(a_lambda)
    puts "I'm the method!"
    a_lambda.call
  end

  lambda_demo(lambda { puts "I'm the lambda!" })
```

### Lambda syntax

Defined using the following syntax:

```ruby
  lambda {|param| block}
```
A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.

Convert an array of string into symbols. Just like with procs, we'll need to put '&' at the beginning of our lambda name when we pass it to the method, since this will convert the lambda into the block the method expects. You can also call a lambda with the '.call' method, just as you can with proc's

```ruby
  strings = ["leonardo", "donatello", "raphael", "michaelangelo"]
  # Write your code below this line!

  symbolize = lambda {|str| str.to_sym}

  # Write your code above this line!
  symbols = strings.collect(&symbolize)
  print symbols
```

```ruby
  crew = {
    captain: "Picard",
    first_officer: "Riker",
    lt_cdr: "Data",
    lt: "Worf",
    ensign: "Ro",
    counselor: "Troi",
    chief_engineer: "LaForge",
    doctor: "Crusher"
  }
  # Add your code below!

  first_half = lambda {|k, v| v < 'M'}

  a_to_m = crew.select(&first_half)
  puts a_to_m
```
