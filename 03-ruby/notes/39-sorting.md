# Sorting

## Objectives

1. Introduce the usefulness of sorting data.
2. Introduce how the basic Ruby `sort` method works under the hood.

Sorting collections of data is a very common task in programming. As a developer, you can imagine being confronted with the need to sort items by price, or emails by their position in the alphabet, for example. There are a number of ways to execute sorting in Ruby. Here we'll discuss one basic example and learn how to sort a list of words.

## Dinner Party Example

You are a famous chef hired to cater a dinner party for the President of Programlandia. Mr. President has his quirks and he'd like for you to print the dinner menu by listing the dishes in alphabetical order. Unfortunately, you weren't prepared for this request and you already have a list of dishes that are *not* alphabetized.  

So, we have a program that contains a variable, `dishes`, that points to an array of your delicious dishes:

```ruby
dishes = ["steak", "apple pie", "vegetable soup"]
```

### Comparing Strings

We need to sort the dishes in this array into alphabetical order. We've already learned about comparison operators like `>` ("greater than") and `<` ("less than") and used them on numbers. These operators work on strings too. If we compare strings using these operators, the comparison operator will look at the first letter of each string and compare their locations in the alphabet. Letters later in the alphabet are considered *greater than* letters earlier in the alphabet. For example:

`"zoo" > "apple"`

Will return

`true`

## The `.sort` method

In order to sort our list of dishes, we will have to iterate over the array and compare every set of items. So far, when we've iterated with methods like `.each` or `.collect`, we iterate over *one element of the collection* at a time. Now, in order to compare the elements in our array to one another, we need an enumerator that allows us to yield two elements at once. That's where the `.sort` method comes in.

The sort method yields to a block with two elements. That block is the comparator, so it should compare the two elements and return 0 if they are the same, -1 if the first is less than the second, and 1 if the first is greater than the second

Let's take a look at a basic example using an array of numbers:

```ruby
array = [7, 3, 1, 2, 6, 5]

array.sort do |a, b|
  if a == b
    0
  elsif a < b
    -1
  elsif a > b
    1
  end
end
```

Other enumerator methods like `.each` we call like this:

```ruby
array.each do |num|
	puts num
end
```

The `.each` method starts at the beginning of the array and passes each item *one at a time* to the code in the block (the code in between `do`...`end`). We see `.each` passing each element of the array to the block here: `|num|`, by placing a placeholder for each element in between the pipes (`| |`).

The `.sort` method is different. It passes elements *two at a time* into the block, and compares those two elements inside the block with our `if` & `elsif` logic:

* If `a` and `b` are equal, the block will return `0`, and `.sort` will leave them in their current places.
* If `a` is less than `b` and belongs before it, the block will return `-1` and `.sort` will once again leave them in their current places (because `a` is already before `b`.)
* If `a` is greater than `b` and belongs after it, the block will return `1` and `.sort` will switch the locations of `a` and `b`.  

Therefore, when we call:

```ruby
array = [7, 3, 1, 2, 6, 5]

array.sort do |a, b|
  if a == b
    0
  elsif a < b
    -1
  elsif a > b
    1
  end
end
```

The first time through the collection, `.sort` passes `7` and `3` into the block and compares them, since 7 is greater than 3, it switches the location of those two elements. If we were to look at the array after going through just one iteration of `.sort`, it would look like this:

`[3, 7, 1, 2, 6, 5]`

On the second pass through the array, `.sort` yields the next two items to the block, in this case `7` and `1`. It compares them in the same way, makes any necessary changes to the location of the items in the array, and then moves on to the next pair.

## Ruby Abstraction: The Spaceship Operator

Now that we have an understanding of how `.sort` works, we can introduce a level of abstraction by using the "spaceship operator" (`<=>`). The spaceship operator, also called the **combined comparison operator**,

* returns `0` if the first operand equals the second,
* returns `-1` if the first operand is less than the second, and
* returns `1` if the first operand is greater than the second.

So, instead of utilizing `if` & `elsif` logic like we did above, we can simply call `.sort` with the following code:

```ruby
array = [7, 3, 1, 2, 6, 5]

array.sort do |a, b|
  a <=> b
end

#  => [1, 2, 3, 5, 6, 7]
```

## Sorting our dinner party menu

Now that we understand how strings are compared and how `.sort` works, we're ready to sort our dinner party menu from the earlier example:

```ruby
dishes = ["steak", "apple pie", "vegetable soup"]

dishes.sort do |a, b|
	a <=> b
end

 # => ["apple pie", "steak", "vegetable soup"]
```

We did it—the menu is alphabetized! Now, let's take it a step further.

## Ruby Abstraction: `.sort`

 Drop into IRB and enter the following code:

```ruby
dishes = ["steak", "apple pie", "vegetable soup"]

dishes.sort
```

It should return : `["apple pie", "steak", "vegetable soup"]`.

Simply calling `.sort` has the desired effect. It implicity executes the code we used in the block in the above example. But now we understand *how* sort works, not just *what* it does.

**Advanced:** *Think about customizing a sorting method. Since* `.sort` *takes a block, can we tell* `.sort` *to sort in reverse alphabetical order? In other words, can we sort a collection of data from greatest to least?*

## Resources

* [Dot Net Pearls - Sort Ruby](http://www.dotnetperls.com/sort-ruby)
* [Ruby Docs - Array - sort](http://ruby-doc.org/core-2.2.0/Array.html#method-i-sort)
* [Watch sorting happen](https://www.youtube.com/watch?v=kPRA0W1kECg)
* [Compare different sorting algorithms](http://www.sorting-algorithms.com/)
