# Creating Objects

## Objectives
+ Create a constructor function
+ Use a constructor function to create an object
+ Explain what a constructor function is and how it works
+ Explain what `this` is in the context of an object

## Introduction

Simple variables are great for holding primitive data types, like strings and integers, but we often need a way to represent more complex data, associating many values to a single idea. In JavaScript, the `Object` is the basic associative data structure, and it works just like a dictionary. We can use these objects to associate data *values* with unique *keys*, giving us a human-readable representation of a logical collection of data.

We can construct objects in JavaScript using the literal constructor:
`{}` and giving it some properties. Let's make a few sandwiches:

```js
var blt = {
  bread: "white",
  crust: false,
  meat: "bacon",
  condiments: "mayo",
  veggies: ["lettuce", "tomato"],
  cheese: "none"
}

var turkeyClub = {
  breadType: "sourdough",
  crust: true,
  meat: ["turkey", "bacon"],
  condiments: "mayo",
  veggies: ["lettuce", "tomato"],
  cheese: "cheddar"
}

var grilledCheese = {
  breadType: "white",
  crust: false,
  meat: "none",
  condiments: "none",
  veggies: "none",
  cheese: "cheddar"
}

```

Great. Three sandwiches. Plenty to share so we don't get into a...
situation.


You probably felt like this got tedious, however, and we only made three sandwiches. We're *[repeating ourselves](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)* a lot, copying and pasting (or, even worse, re-typing!) all of the same keys for our objects.

### Objects vs. Object-Oriented

When we talk about objects in terms of data structures it's simple. The language
provides us with an `Object` type that helps us encapsulate data into
key/value pairs.

What we want to do now though is talk about objects in terms of
*object-oriented programming*, which goes beyond simple data structures.

In object-oriented programming, we use objects to represent logical and
often physical concepts, such as students, books, and even delicious
sandwiches. In object-oriented programming (OOP), our objects should
not only allow us to *encapsulate* data (i.e. gather and store values
that are attributes of the object, such as `meat` and `condiments` in a
`sandwich`), but also allow us to *reuse* the data structure without
constantly redefining it.

In other words, we should only have to define the properties of a sandwich
one time and then be able to create as many different sandwiches as we
want without repeating ourselves.

Is there a way to use JavaScript to create a template for a sandwich object that we can use
to construct many different sandwiches?

### Constructor Function

Of course there is! It's called a *constructor function*, and its job, as you might guess from the very on-the-nose name, is to construct new objects. We use the constructor function pattern to essentially build a *prototype* for what an object will look like, including all the properties.

**Advanced:** We call the constructor function a *pattern* because it's
not a concept that's built-in to the JavaScript language, but rather a
design pattern that has evolved in to common usage as an accepted
standard way to instantiate an object. Patterns can be small,
task-oriented recipes, such as this constructor function, or they can be
big, architecture-oriented guidelines, such as the MVC pattern at the
root of a framework like Ruby on Rails or AngularJS. You can read more about design
patterns [here](http://www.oodesign.com/).

Let's build a constructor function for our sandwich objects:

```js
function Sandwich(bread, crust, meat, condiments, veggies, cheese) {
  this.breadType = bread;
  this.crust = crust;
  this.meat = meat;
  this.condiments = condiments;
  this.veggies = veggies;
  this.cheese = cheese;
}
```

You'll notice the name of the constructor function `Sandwich` starts with a capital letter. This is important. While the capitalization of a function does not affect how it behaves, it serves as an important signal to our fellow programmers that this function should ONLY be used as a constructor. Adhering to this *convention* is a good way to communicate intent to other developers who may have to maintain this code.

Next, we define the function to accept a whole bunch of parameters. When we create objects with this constructor function, we'll pass in the value of the properties we want our object to have.

**Top-tip:** You'll notice inside the body of the constructor function we're using `this` in front of each of the property names. In this case, `this` will refer to the current object being created, and it's how we differentiate between the *property* `crust` and the local variable `crust` that we got from the function arguments.

### Creating an Instance From a Constructor Function

Now that we have a constructor function, let's create our sandwiches:

```js
var blt = new Sandwich("white", false, "bacon", "mayo", ["lettuce", "tomato"], "none");

var turkeyClub = new Sandwich("sourdough", true, ["turkey", "bacon"], "mayo", ["lettuce", "tomato"], "cheddar");

var grilledCheese = new Sandwich("white", false, "none", "none", "none", "cheddar");
```

Notice that when we call these functions, we always call them with the `new` keyword. JavaScript needs us to use the `new` keyword to instantiate a new instance of an object. Without it, we're just invoking the function and setting it to the value of a variable, and since the function doesn't return anything, our variable will be `undefined`.

All functions in JavaScript can be invoked with the `new` keyword, but we only want to do it with functions that are intended to be used as constructor functions. The way we let ourselves and others know when to use the `new` keyword is by making constructor functions start with capital letters! If we forget the `new` keyword we'll run into all sorts of problems.

How do we know that these are objects and that they were all created using the same constructor function?  We can look at the `constructor` property, which gets set automatically during the initialization of the object.

```js
blt.constructor;
// returns the Sandwich constructor function
turkeyClub.constructor;
//returns the Sandwich constructor function
grilledCheese.constructor;
//returns the Sandwich constructor function
```

### Reading Property Values

So now that we used the constructor function, how do we read the properties of an object?

You can access the properties just like you did when we were treating objects as hashes:

```js
blt["breadType"];
//returns white
turkeyClub["meat"]
// returns ["turkey", "bacon"]
grilledCheese["crust"]
//returns false
```

Or, you can use the dot-notation you're familiar with from Ruby:

```js
blt.breadType;
//returns white
turkeyClub.meat;
// returns ["turkey", "bacon"]
grilledCheese.crust;
//returns false
```

### Reassigning Property Values

Let's say you actually like to eat your grilled cheese with a slice of bacon and tomato, we would need to change the values of the `meat` and `veggies` properties:

```js
grilledCheese["meat"] = "bacon";
grilledCheese.veggies = "tomato";
```

Now, I don't know why you'd ruin a perfectly good grilled cheese with tomatoes, but I'm not here to tell you how to live your life.


## Summary

We've reviewed working with objects in JavaScript, and started to think about *object-orientated programming* by applying the *constructor function* pattern when creating objects so that we can easily define and reuse objects that we design.
