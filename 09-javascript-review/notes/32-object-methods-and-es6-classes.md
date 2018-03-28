# Object Methods and Classes

## Objectives
+ Explain what a method is and the difference between a method and a function.
+ Add an action to a constructor function.
+ Explain what `this` is in the context of an object.
+ Create ES6 classes.
+ Explain ES6 class inheritance with `extends`.

## Introduction
Objects have both data and behavior. Data comes in the form of properties that store information, such as the `length` of an array, or the `name` of a Person. But objects also can have properties that store behavior, or functions, such as the `slice()` method of an array. When a function is a property of an object, it is known as a *method* of that object.

## Adding Methods to an Object
Let's create a constructor function for some `User` objects.

```js
function User (name, email){
  this.name = name;
  this.email = email;
}
```

How do we give our JavaScript user objects the ability to say hello?

We already know how to create functions.  Now we need to attach a function to an object as a property.

```js
function User (name, email){
  this.name = name;
  this.email = email;
  this.sayHello = function(){
    console.log("Hello, my name is " + this.name);
  }
}
```

We've now added the `sayHello` method to our `User` constructor function. Because a method is just a function that is attached to an object via a property, `sayHello` is a method. We call `User` a function, and not a method, because it's a standalone function and not a property of any object.

It's a semantic distinction. All methods are also functions. We just use "method" as a convention when we communicate that lets other people know that we mean a function that is part of an object.

It's important to note that we use `this` twice in relation to the `sayHello` method. We use it once: `this.sayHello`, where `this` is referencing the object we'll create (as long as we invoke the function with the `new` keyword).  The `this` keyword is probably the most confusing concept in JS so for now let's just assume it works like Ruby's `self` and refers to the instance of the object we're refering to.

Let's make a few users:

```js
carl = new User("Carl", "sparkles@aol.com");

betsy = new User("Betsy", "betsy@flatironschool.com")

george = new User("George", "george@me.com")
```
We can have the users greet us too:

```js
carl.sayHello();
// prints "Hello, my name is Carl" to the console
betsy.sayHello();
// prints "Hello, my name is Betsy" to the console
george.sayHello();
// prints "Hello, my name is George" to the console
```

But there's a problem here. When we build the method directly into the constructor function like this, we're using a lot of space in memory. Every single time a `User` object is created and stored in memory, the `sayHello` function is created and stored in memory with it. What if you're Facebook and have 1.19 billion active users a month? If you were to instantiate all those users at once, you'd be recreating that function in memory 1.19 billion times! (Incidentally, this is how Ruby does it.)

## Add Method to Prototype
Javascript objects have something called a Prototype.  For now, we won't get into an extremely detailed discussion of what Prototypes are, but we will use them as a place to keep our "instance" methods.  In Javascript, when you call a property, the interpreter will look on the instance of the object for a property, and when it finds none, it will look at the Object's Prototype for that property.  If we've attached a function as the property of that name it will call that function in a similar way that Ruby's method lookup chain works.

```js
function User(name, email) {
  this.name = name;
  this.email = email;
}

User.prototype.sayHello = function() {
  console.log("Hello, my name is "+ this.name);
}

var sarah = new User("sarah", "sarah@aol.com");

sarah.sayHello();
```

For all intents and purposes, we've created a JS class following a common pattern that combines the use of constructor functions with extending behavior via the object's prototype. This works, but is incredibly verbose, and you always run the risk of forgetting to add methods to the prototype instead of directly to the constructor.

It would be nice if there were an approach that allowed us to construct true *classes* while still taking advantage of the prototypal nature of JavaScript. But there's no way to do that.

OR IS THERE?

(There is.)

## ES6 Classes
ECMAScript 6 introduces the concept of a `class` to JavaScript that provides a handy shortcut for organizing our objects.

It's important to note that the `class` keyword doesn't actually turn JavaScript into a class-based object-oriented paradigm. It's just *syntactic sugar*, or a nice abstraction, over the prototypal object creation we've been doing.

Let's convert our user to a class.

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  sayHello() {
    console.log("Hello, my name is "+ this.name);
  }
}

var sarah = new User("Sarah", "sarah@aol.com");
sarah.sayHello();
```

Instead of our `User` constructor function, we now have a `class User`. Within the body of the class, we can define a special function named `constructor` to be our constructor function. In the end, we still instantiate a `new User` the same way.

We also define our `sayHello` function directly in the body of the class. However, unlike defining it in the constructor function, we can verify that `sayHello` is defined on the User prototype by examining `User.prototype`.

## ES6 Class Inheritance With extends

We can also easily inherit from ES6 classes without having to go through the trouble of assigning `prototype` via `Object.create`.

Say we want to create a `Teacher` class for our school system that inherits from `User`. We can just define a new class and use the `extends` keyword.

```js
class Teacher extends User {
    sayHello() {
      super.sayHello()
      console.log("I am a teacher");
    }
}

var t = new Teacher("Tom", "tom@geocities.edu")
t.sayHello()
```

Here, we've *extended*, or inherited from `User` when creating the new `Teacher` class. We also created an *override* to the `sayHello` method so that it would reflect our teacher object better.

If you look at the line `super.sayHello()`, what we're doing there is calling the `sayHello` method of the *superclass*, or the class (`User`) that our `Teacher` class inherits from. We wanted to preserve the behavior that was already there and then add to it, so rather than repeat the code, the `super` object gives us access to it programmatically.

## Summary

In this lesson, we've learned the differences between methods and functions, and seen how to add methods to objects through both the constructor and the prototype.

We also explored the new `class` syntax of ES6 and how to create and extend classes using it.

## Resources

+ [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)
+ [MDN: Classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)
