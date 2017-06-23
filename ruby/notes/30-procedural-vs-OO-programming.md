# Procedural vs. Object-Oriented Ruby

## Overview

What's the difference? Well, in **procedural programming**, we have data and we have the procedures or instructions for operating on that data. In procedural programming, data and procedures, or instructions, are two separate things. In **object-oriented programming**, we have units of code that contain *both* data *and* instructions, such that an "object" operates on its own data structure.

Let's take a look at an example of this distinction using some methods you might find in a procedural implementation of Tic Tac Toe.

## Procedural Programming: Tic Tac Toe

```ruby
board = Array.new(9, " ") # Creates an array with 9 elements filled with " "

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
```

In the code above, we have a `board` variable which points to an Array that represents our game board. Each of our methods *must* take the `board` array in as an argument and operate on that array. Here, our data structure, the `board` array, is operated on by each method. The data is *separate* from the behavior or operations.

In fact, the `board` array is so separate from the behaviors defined in our method that the only indication that our data and our methods are related is the fact that the `board` array is defined in the same general area (i.e. in the same file, close to the lines where we define our methods) as our methods.

Another thing to note about our procedural approach to tic tac toe above is that we constantly have to pass around the `board` array to every method. This is tedious and potentially very troublesome as any method can modify that variable and continue passing it around, thus causing errors in our program.

**What's so bad about our procedural approach?** Ultimately, we don't want to manage our data through proximity and arguments, we want to teach our *objects* to manage their own data. What happens if we want to grow our tic tac toe game by adding more data or more behaviors? Our program gets messy, fast. The more we add different data and behaviors that are linked only by proximity or via arguments, the more confusing and buggy our program is likely to be.

Consider the following object-oriented implementation of our tic tac toe game:

## Object-Oriented Tic Tac Toe: Tic Tac Toe

```ruby
class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end
```  

**What's so great about our object-oriented approach?** Notice that every method became easier to understand. They no longer require arguments and instead can rely on the *internal state of the object*. What do we mean by that? Well, in our `TicTacToe` class, the board array is a *property of an instance of the TicTacToe game*. The `@board` instance variable, and the data that is stored in it, is attached to the instance of the game that is playing out at a given point in time. The *state* of the game, i.e. who is winning, what squares have been filled in, is expressed by the content of the `@board` variable, which itself is a property of the given instance of `TicTacToe`.

The methods of our `TicTacToe` class are also part of an object. When we called `TicTacToe.new` and create a new instance of the class (and start a new game), that instance, that tic tac toe object, has properties, like the `@board` variable, that describe its state. That tic tac toe instance will also have methods that allow it to enact behaviors and operate on the data stored in its properties. Our tic tac toe object has the whole package––attributes that contain data describing the state of the object *and* methods that enact behaviors on that data.

Not only is our code now more organized and easier to read and understand, it is also accommodating of future growth and change. We can add more methods and more attributes to our `TicTacToe` class without over complicating our program.

## Moving from Procedural to Object-Oriented

How do we refactor a procedural program into an object-oriented one? The things you want to look for when refactoring procedural code into object-oriented code are:

1. Find any data the methods rely on. Is this data related to the core functionality of our program? If so, think about where this data belongs. Should you pass it in as an argument to an `#initialize` method? Can the class you are writing create the data structure itself?

2. Are your methods passing data around as arguments? Could this data instead be made into an instance variable?

3. Is there any code that isn't contained in a method? Could that code be placed inside a method in your class and therefore become behavior that belongs to your object?

Anything that works procedurally can also work in an object-oriented fashion and being able to move between these two styles of programming is crucial.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/procedural-vs-oo-ruby' title='Procedural vs. Object-Oriented Ruby'>Procedural vs. Object-Oriented Ruby</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/procedural-vs-oo-ruby'>Procedural vs Object Oriented Ruby</a> on Learn.co and start learning to code for free.</p>
