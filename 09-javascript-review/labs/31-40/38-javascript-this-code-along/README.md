# JavaScript this Code-Along

## Overview 

In this lesson we'll be exploring the ways we can manipulate `this` to use functions in new ways.

## Objectives

1. Use `this` with functions in JavaScript
2. Use `call()` and `apply()` to invoke a function with an explicit value for `this`
4. Explain the difference between `call()` and `apply()` in the way you pass arguments to the target function.
5. Use `bind()` to execute functions asynchronously 

## Introduction

You know that we can create objects in JavaScript and store data in their properties, call methods on them, and pass them around between functions.

And you know that you can reference `this` inside of a function to find out what the function's owner is, and perform operations based on that owner.

But did you know that functions are also objects? And that we can borrow functions from one object and use them on another object? Or hold on to a function with specific arguments and call it later?

If you didn't understand all that, that's okay. In this lesson we'll be exploring the ways we can manipulate `this` to use functions in new ways.

Don't forget to code along in your console!

## Plain Ol' JavaScript Objects (POJOs)

We can create objects in JavaScript to associate values to properties, like a sandwich:

```js
var pbj = {
  bread: "white",
  ingredients: ["peanut butter", "jelly"],
  cut: "triangles"
}
```

We can also use a constructor function to create all kinds of sandwich objects:

```js
function Sandwich(bread, ingredients, cut) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.cut = cut;
}

var blt = new Sandwich("white", ["bacon","lettuce","tomato","mayo"],"rectangle");
var reuben = new Sandwich("rye", ["corned beef","sauerkraut","swiss","russian dressing"],"diagonal");
```

And we can even attach a function to an object like this:

```js
var pbj = {
  bread: "white",
  ingredients: ["peanut butter", "jelly"],
  cut: "triangles",
  name: "peanut butter and jelly",
  serve: function() {
    console.log("here's your " + this.name + ", enjoy!");
  }
}
```

Now try calling `pbj.serve()`.

### this and Functions

When we called `pbj.serve()` above, it gave us the message with the `name` value for our sandwich. The `this.name` refers to the `name` of the `pbj` object, because `pbj` invoked the `serve()` function, becoming the owner of that function.

If we wanted to explicitly construct a BLT with a `serve()` function, we could do that:

```js
var blt = {
  bread: "white",
  ingredients: ["bacon", "lettuce", "tomato"],
  cut: "diagonal",
  name: "BLT",
  serve: function() {
    console.log("here's your " + this.name + ", enjoy!");
  }
}

blt.serve();
```

This works, but now we're repeating this `serve` function everywhere and that's not only a violation of the [DRY principle](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) but also just a total pain.

How can we apply what we know about constructor functions to this problem?

It stands to reason that if we can set primitive property values in a constructor function, we should be able to create methods on the object we're constructing as well. Let's give it a shot.

```js
function Sandwich(bread, ingredients, cut) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.cut = cut;
  this.serve = function() {
    console.log("here's your " + this.name + ", enjoy!");
  }
}

var blt = new Sandwich("white", ["bacon","lettuce","tomato","mayo"],"rectangle");

blt.serve();
```

Oops! Not quite what we were looking for, but close. The function worked, but we got `undefined` for `this.name`. Why?

Here, `this` refers to the instance of `Sandwich` that we constructed. We didn't add the `name` property to our constructor function, so `this` blt doesn't have a `name`, so the `serve` function doesn't have anything to fill in there.

There are a couple of ways we could solve this problem. We could add a `name` to the constructor function, but then we'd have to change the code for every sandwich we've created to add that new argument. In a bigger system, that might introduce bugs in code we don't know about.

Instead, we can take advantage of JavaScript and add a `name` property to just our `blt` and try calling the function again.

```js
function Sandwich(bread, ingredients, cut) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.cut = cut;
  this.serve = function() {
    console.log("here's your " + this.name + ", enjoy!");
  }
}

var blt = new Sandwich("white", ["bacon","lettuce","tomato","mayo"],"rectangle");
// add name to the blt before serving
blt.name = "BLT";
blt.serve();
```

Perfect! Now our blt's `serve` function can access a `name`. If we were to create another `Sandwich`, and try to call `serve()` on it without setting the name, we'd get the `undefined` value for `this.name` again, because by defining the `serve` function within the constructor function, we've bound `this` to whatever current instance is being constructed.

But this brings up some interesting thoughts. If we can add more properties to an object and change its definition at runtime, and if functions are objects, can we invoke functions in a way that allows us to bind new values to `this` to get new results?

What if we decided that we wanted to `serve()` something other than a sandwich? I don't know why we would want to do that, because sandwiches are perfect, but some people like to eat other things, I guess.

## Alternate Ways to Invoke Functions

Normally, when we want to invoke a function, we simply call it by name directly, like `serve()`. But there are cases when we want to modify how the function is called, and more specifically, modify the `this` property of the function.

Let's go back to our `serve` example. We said that there's an off chance that someone will want to eat something other than a sandwich. So we decide to make `serve` a function separate from sandwich.

```js
function serve() {
  console.log("here's your " + this.name + ", enjoy!");
}
```

Okay, let's call `serve()` now. Back to that `undefined` problem, right? Of course. Now that the function is all by itself, `this` will be either `window`, which doesn't have a `name` property, or, if we are in *strict mode*, `this` remains `undefined` when the function is called.

We could certainly modify `serve` to take an object with a `name` as an argument here, but what if the rest of the system is designed around using the `serve` function without an argument?

What we need is a way to invoke `serve` with a value for `this` that we can control.

### call() and apply()

Fortunately, JavaScript gives us a way to do exactly what we need. Two ways, in fact!

We can use `call()` or `apply()` to invoke a function with an explicit value for `this`. Let's see it in action, first with `call`.

First, let's go back to our `Sandwich` constructor function and make a couple of sandwiches:

```js
function Sandwich(bread, ingredients, name) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.name = name;
}

function serve() {
  console.log("here's your " + this.name + ", enjoy!");
}

var gc = new Sandwich("white", ["cheese"], "Grilled Cheese");
var pbj = new Sandwich("wheat", ["peanut butter", "raspberry jam"], "Peanut Butter & Jelly");
```

Okay, now we want to be able to do the equivalent of `gc.serve()`, but `serve` is no longer part of the `Sandwich` constructor. This is where
`call()` comes in.

```js
serve.call(gc);
serve.call(pbj);
```

We should see the correct message for each sandwich!

What's happening here? Remember that a function is also an object, so a function can have properties, like `this`, and it can also have its own methods, in this case, `call`. Instead of invoking the `serve()` function directly, we're invoking the `call()` method of the `serve` function.

The first argument for `call` is always the object that you wish to assign to `this` for the function. So by using `call(gc)`, we called the `serve` function, setting `this` to our `gc` sandwich object. That way, when we accessed `this.name` inside of the function, it knew the right sandwich for `this`.

For a simple, no argument function like `serve()`, we can use `apply()` interchangeably with `call()`. The first argument for `apply()` is also always the object that we want to assign to `this` in the function, so `serve.apply(gc)` will work exactly the same as `serve.call(gc)`. Try it out!

So both `call` and `apply` give us a way to invoke a function and explicitly set `this` with the first argument. What is the difference?

#### Passing Arguments With call() and apply()

The only real difference between `call` and `apply` is the way you pass arguments to the target function.

Let's modify our `serve` function to be a little friendlier:
```js
function serve(customer) {
  console.log("Hey " + customer + ", here's your " + this.name + ", enjoy!");
}

var gc = new Sandwich("white", ["cheese"], "Grilled Cheese");
var pbj = new Sandwich("wheat", ["peanut butter", "raspberry jam"],
"Peanut Butter & Jelly");
```

Now, when we invoke `serve`, not only do we need to explicitly set `this`, but we also need to pass in a value for `customer` as well.

Using `call`, we simply pass the object for `this` as the first argument, and then any function arguments in order after that. So to use `serve` with `call`, let's do this:

```js
serve.call(gc, "Terry");
serve.call(pbj, "Jesse");
```

Great! Now we see the name and the message! What happens if we don't pass that second argument?

```js
serve.call(gc);
```

We'll have an `undefined` value for `customer`. What if we skipped the `this` argument and just passed the customer value?

```js
serve.call("Terry");
```

Double `undefined`! Why? Think about what's happening here. We said that the first argument to `call()` or `apply()` is **always** the value for `this`, so inside our `serve` function, this is being set to the string literal `"Terry"`, and no value is being set to the `customer` variable. Inside of `serve`, when it tries to access `this.name`, it gets undefined, because the value of `this`, that string literal, doesn't have a `name` property.

Okay, what about `apply`? Again, this works very similar to `call`, except that `apply` only takes two arguments: the value of `this`, and then an *array* of arguments to pass to the target function. So to use `apply` with our new serve object, we'll need to pass that customer value inside an array.

```js
serve.apply(gc, ["Terry"]);
serve.apply(pbj, ["Jesse"]);
```

Very similar, but we need to wrap that second argument in brackets to make it an array.

Let's add a function to tell a server where to deliver the sandwich to see how `call` and `apply` are different with more arguments.

```js
function deliverFood(customer, table) {
  console.log("Delivering " + this.name + " to " + customer + " at table " + table);
}

deliverFood.call(gc, "Terry", "4");
deliverFood.apply(pbj, ["Jesse", "15"]);
```

In this case, `deliverFood(customer, table)` takes two arguments. So when we use `call`, we pass first the sandwich we want to assign to `this`, then the two arguments in order.

When we use `apply`, we also pass in the sandwich first to assign to `this`, but then we only pass one more argument, which is an array of the rest of the arguments for the `deliverFood` function.

The choice to use `call` or `apply` here is essentially down to preference. They do the same things, with slightly different ways to pass arguments to the target function.

Okay, let's have a little more fun. One place where `apply` and `call` get more interesting is when working with *[variadic functions](https://en.wikipedia.org/wiki/Variadic_function)*, or functions that take a variable number of arguments.

Imagine we need to serve our food to any number of customers. Grilled cheese is very popular, and many people are likely to order it at once! We want to be able to call out the order to any number of people at runtime, so we might design a method like this:

```js
function serve() {
	if(arguments.length > 0) {
		var customers = Array.prototype.slice.call(arguments);
		last = customers.pop();
  		console.log(this.name + " for " + customers.join(", ") + " and " + last + ". Enjoy!");
	}else {
		console.log(this.name + ". Order up!");
	}
}
```

There's a lot going on here, so let's unpack this. First, you'll notice we check the length of `arguments`, which is an object that JavaScript provides within a function that contains all of the arguments passed to that function.

But our function declaration, `serve()`, doesn't have any arguments!

It doesn't have any defined, but you can still pass them. Here, we have a function that may get some customers passed to it, but may not. If it doesn't, then `arguments.length` will evaluate to zero. We can try this out:

```js
serve.call(gc);
serve.apply(pbj, ["Terry", "Tom", "Tabitha"]);
```

The first one should give us the message *"Grilled Cheese. Order up!"*.
The second should yield *"Peanut Butter & Jelly for Terry, Tom and Tabitha. Enjoy!"*

In this case, we used `apply` for the second one, but that could just as easily have been `call`. Because the function is not set up to take any specific arguments, we can just use an array of values as the second argument to `apply` or `call` and it will be picked up by the `arguments` object within the function body.

#### Borrowing Functions With call() and apply()

Okay, we've seen the output, but what else is happening in there? Notice this line?

```js
var customers = Array.prototype.slice.call(arguments);
```

This is a great example of using `call` in the real world. We have access to this `arguments` object, which is not a true array, but is an *array-like* object. We can use the `slice` function to "convert" an array-like object to an array of that object's values.

The `arguments` object doesn't have a `slice` method, because it isn't an array, so we have to go through `Array.prototype` to get to the `slice` function, and then explicitly set its `this` to our `arguments` in order to turn them into an array. This is known as *borrowing* a function.

**Advanced:** You can think of the `prototype` property of an object as the template for the non-instantiated version of that object. In the example above, rather than using `slice()` on an instance of `Array`, we're accessing the `slice` method on the `Array` prototype, which is why we have to use `call` to give it a valid owner on which to operate. For more information about `prototype`, check out the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/prototype) for `Object.prototype`.

Function borrowing is a great way to use the functions of another object without having to explicitly write them into your object.

Let's say we have a function that describes the ingredients of our sandwich, and it's a method of our `Sandwich` object:

```js
function Sandwich(bread, ingredients, name) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.name = name;
  this.describe = function() {
    console.log("Your " + this.name + " includes: " + this.ingredients.join(", ") + ". Yum!");
  }
}

var pbj = new Sandwich("wheat", ["chunky peanut butter", "blackberry preserves"], "PB&Jam");

pbj.describe();
```

Awesome. Now we can describe our sandwich. Now someone comes to our lunch counter and wants a salad. We can represent a salad pretty easily:

```js
var salad = {
  ingredients: ["croutons", "romaine hearts", "steak", "parmesan", "caesar dressing"],
  name: "Steak Caesar"
}
```

We want to be able to describe this salad, but it's not a sandwich, so we can't just call `salad.describe()`. However, since we know we can borrow functions from other objects with `call` and `apply`, we should be able to do that here:

```js
pbj.describe.call(salad);
```

There we go! Our salad described as if it were a sandwich object! Again, this works because we use `call` to explicitly set `this` on the `describe` method to our salad object, even though the function is attached to an instance of a `Sandwich`.

**//Flat-fact:** You don't win friends with salad.

![you don't win friends with salad](http://i.giphy.com/xT0GqFjfmAUuE4wRqw.gif)

### bind()

So far, we have been looking at `call` and `apply`, which explicitly set `this` and then immediately execute the function call.

Sometimes, however, we need to be able to hold on to the function and delay calling it until later. For this, we use `bind()`.

#### Borrowing Functions with bind()

In our earlier borrowing example, we used `call` to describe a salad from our sandwich `describe` method:

```js
pbj.describe.call(salad);
```

This works, but it's semantically very ugly. Operating with the idea that our code should be communicative and clear, it doesn't make a lot of sense that you would describe a salad from a sandwich.

What we'd really love to do is borrow the `describe` function in a way that we can call it from our salad. That's where `bind` comes in.

Using `bind` is similar to `call` in that the first argument will be the value for `this` in the target function, then any arguments for the target function come in order after that.

The big difference between `bind` and `call` is in the execution. When we use `call`, we execute the function immediately. When we use `bind`, we actually create a new function with that `this` value set, and we can execute it whenever.

Try this with our earlier example:

```js
pbj.describe.bind(salad);
```

We didn't get our message. Depending on your console, you might have seen a message that says the function was bound, or you might see just an output of the body of the function, but it didn't execute and log our message.

That's because we need to hold our bound function somewhere so we can call it later. Let's try this:

```js
var describeSalad = pbj.describe.bind(salad);
```

Now we've bound the function, with `salad` assigned to `this`, into a new function called `describeSalad`. Let's try executing our new function.

```js
describeSalad();
```

There's our message! So we bound the function to `salad`, saved it, and executed it later. But we're here to borrow a function and make our code read nice, so let's try something else.

We know that we can assign new properties and methods to objects at runtime. Since our `salad` doesn't have a `describe` method, let's give it one using `bind`.

```js
function Sandwich(bread, ingredients, name) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.name = name;
  this.describe = function() {
    console.log("Your " + this.name + " includes: " + this.ingredients.join(", ") + ". Yum!");
  }
}

var pbj = new Sandwich("wheat", ["chunky peanut butter", "blackberry preserves"], "PB&Jam");

var salad = {
  ingredients: ["croutons", "romaine hearts", "steak", "parmesan", "caesar dressing"],
  name: "Steak Caesar"
}

salad.describe = pbj.describe.bind(salad);
```

Okay, using our same `Sandwich` object, we're now borrowing `describe` from `pbj` using `bind`, and assigning it to `salad.describe`. All that remains is to test it out by executing `salad.describe()`.

It works! We've successfully borrowed the function, given it to `salad`, and we can execute it whenever we want!

#### Asynchronous Execution With bind()

We know that we can use `bind` to create a new function that we can use later, which sounds exactly like what we need to execute functions asynchronously, such as when using `setTimeout` or `setInterval`.

Let's take our lunch restaurant a step further, and imagine a function to send a server to a table to check on a customer. That function might look something like this:

```js
function visitTable() {
  console.log("The server is visiting " + this.name + " at table number " + this.tableNumber);
}
```

Then we'll have a `Customer` object that we'll use to represent new customers when they come in.

```js
function Customer(name, tableNumber) {
  this.name = name;
  this.tableNumber = tableNumber;
}
```

Now when a new customer comes in, we want to create a new customer object, then set up a timer for the server to come after they've had enough time to look at the menu.

We know that `setTimeout` takes a function as an argument, and we know that we can't directly invoke `visitTable()` because we need to set `this`. Let's use our new friend `bind` to create a new function with that customer bound to `this` that we can execute within `setTimeout`.

```js
//create new Customer instance
var sally = new Customer("Sally", "4");

//schedule table visit
var visitSally = visitTable.bind(sally);
setTimeout(visitSally, 1000);
```

And we can continue like this, using `bind` to create new functions for each customer that comes in, setting the `this` for the function to that customer, and giving those functions to `setTimeout` to schedule table visits for each person.

## Summary

We reviewed how to create and instantiate POJOs, and how `this` works for simple function calls. Then we explored `call` and `apply` to see how we can instantly execute functions while providing a different `this` value explicitly.

We learned how to *borrow* functions from other objects using `call`, `apply`, and `bind`, and how to use `bind` to make copies of functions with a new `this` and execute them later.

## Resources

- [MDN: Function.prototype.call()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
- [MDN: Function.prototype.apply()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
- [MDN: Function.prototype.bind()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-this-code-along'>Javascript this Codealong</a> on Learn.co and start learning to code for free.</p>
