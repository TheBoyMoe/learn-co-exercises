# Higher Level Hash Methods

##Objectives
* Use the `#values` method to return the values in a hash
* Use the `#keys` method to return the keys in a hash
* Use the `#min` method to return the minimum value of hash

-

Let's learn some interesting methods we can call on hashes. Previously, you were asked to iterate over a hash and collect the key that pointed to the lowest value. We asked you not to use some of the higher level hash methods there. Now, we're going to learn a few tricks that can make a task like that much easier.

### `#values`

You can collect all of the values in a hash with the `#values` method:

```ruby
groceries = {fruit: "Banana", vegetable: "Broccoli", dessert: "Cookie"}

groceries.values
#  => ["Banana", "Broccoli", "Cookie"]
```

We can see that the `#values` method returns an array of the values of the keys in the hash.

### `#keys`

This method, not surprisingly, returns an array containing all of the keys in the hash that `#keys` has been called on:

```ruby
groceries = {fruit: "Banana", vegetable: "Broccoli", dessert: "Cookie"}

groceries.keys
#  => [:fruit, :vegetable, :dessert]
```

### `#min`

You can use the `#min` method on a hash to return the key/value *pair* whose key is the **lowest** value. What return type can return two different things? Arrays!:

```ruby
letters = {a: 1, b: 2}

letters.min
#  => [:a, 1]

alphabetical_order = {c: 100, d: 1}
alphabetical_order.min
#  => [c: 100] # Because the key :c is lower than :d in alpheabetical order.
```

These are only a few of the many helpful methods out there. Be sure to check out the [Ruby Docs on Hashes](http://ruby-doc.org/core/Hash.html) to learn more.

Let's practice before you move on to the next challenge:


## Code Along: Manipulating Nested Hashes

You'll be coding your solution to this challenge in `lib/values.rb`, `lib/keys.rb`, and `lib/min.rb`. We have a nested hash of grocery items.

```ruby
groceries = {
  dairy: ["milk", "yogurt", "cheese"],
  vegetable: ["carrots", "broccoli", "cucumbers"],
  meat: ["chicken", "steak", "salmon"],
  grains: ["rice", "pasta"]
}
```

## Challenge 1: Return the keys
Use the `#keys` method to collect all of the keys of the hash. This one is simple enough.

```ruby
groceries.keys
#=> [:dairy, :vegetable, :meat, :grains]
```

After you have written the correct code in `lib/keys`, check the return value of your method by running `ruby bin/keys` in the terminal.

## Challenge 2: Return the values
Use the `#values` method to collect all of the values of the grocery type keys (`:dairy`, `:vegetables`, `:meat`, `:grains`). The method should return a *one-dimensional* (or "flat") array that *only* includes the values (groceries such as "milk" and "carrots") without their keys.

**Hint:** What happens when you call `#values` on a nested hash? What is the return value? How can you *flatten* an array of arrays? Make sure to use `binding.pry` to help you solve this one.

```ruby
groceries.values
#=> [["milk", "yogurt", "cheese"], ["carrots", "broccoli", "cucumbers"], ["chicken", "steak", "salmon"], ["rice", "pasta"]]
```
Now, to get all the values in a flat array:

```ruby
groceries.values.flatten
#=> ["milk", "yogurt", "cheese", "carrots", "broccoli", "cucumbers", "chicken", "steak", "salmon", "rice", "pasta"]
```

After you have written the correct code in `lib/values`, check the return value of your method by running `ruby bin/values` in the terminal.

## Challenge 3: Return the min
Use the `#min` method to collect the value that comes first alphabetically ("broccoli").

###Step 1. Grab all the grocery values
Lucky for us, we already did this is Challenge 2. If we call, `groceries.values.flatten` we should get back: `["milk", "yogurt", "cheese", "carrots", "broccoli", "cucumbers", "chicken", "steak", "salmon", "rice", "pasta"]`

###Step 2. Get the minimum value
Simply calling `#min` on what we did in Step 1 should do the trick:

```ruby
groceries.values.flatten.min
#=> "broccoli"
```

After you have written the correct code in `lib/min`, check the return value of your method by running `ruby bin/min` in the terminal.

Note: `#min` will also work for the entire hash. Play around in pry to see what is returned when you call `groceries.min`.

## Resources:

* [Ruby Docs on Hashes](http://ruby-doc.org/core/Hash.html)

