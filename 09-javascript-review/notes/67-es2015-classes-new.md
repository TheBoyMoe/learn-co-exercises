# Using Classes in Javascript

## Objectives
+ Understand how to use the class based syntax to declare a constructor for objects.
+ Understand the use of the constructor method in class based syntax.
+ Understand that methods declared with class based syntax are defined on the constructor's prototype.

### Our perfectly working code

We currently have declared our constructor function such that it sets both properties and declares methods on newly created objects.  Moreover, we saw how we can reuse identical methods by defining methods on the constructor's prototype.  Our code looks like the following.

```js

  function User(name, email) {
    this.name = name;
    this.email = email;
  }

  User.prototype.sayHello = function(){
    console.log(`Hello everybody, my name is ${this.name}`);
  }

  let sarah = new User('sarah', 'sarah@gmail.com')

  sarah.sayHello()
  // "Hello everybody, my name is sarah!"
```

It works fine, but its not very pretty.  The problem is that our constructor and use of prototypes are separated from one another.  We want a way to encase both the attributes and functionality produced from a constructor in one spot.  

## ES2015 Classes
ECMAScript 2015 introduces the concept of a `class` to JavaScript that provides a handy shortcut for organizing our objects.

It's important to note that the `class` keyword doesn't actually turn JavaScript into a class-based object-oriented paradigm. It's just *syntactic sugar*, or a nice abstraction, over the prototypal object creation we've been doing.

Let's convert our user to a class.

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  sayHello() {
    console.log(`Hello, my name is ${this.name}`);
  }
}

var sarah = new User('sarah', 'sarah@gmail.com');
sarah.sayHello();
```

Instead of our `User` constructor function, we now have a `class User`. Within the body of the class, we can define a special function named `constructor` which is run each time a new object is initialized from the User class. In the end, we still instantiate a `new User` the same way.

We also define our `sayHello` function directly in the body of the class. However, unlike defining it in the constructor function, we can verify that `sayHello` is defined on the User prototype by examining `User.prototype`.  Also notice that we no longer write the word `function` when defining a method on a JavaScript class.

## ES2015 Class Inheritance With extends

We can also easily inherit from ES2015 classes.  Inheritance is used when we would like to reuse the same functionality from a previously defined class, but would like to extend that class's functionality.

For example, say we want to create a `Teacher` class, such that objects initialized from the Teacher class will inherit the same methods declared on the `User` class. We can just define a new class and use the `extends` keyword.

```js
class Teacher extends User {

}

let tom = new Teacher("Tom", "tom@geocities.edu")
tom.sayHello()
// hello my name is Tom
```

Note that even though we have not defined any methods directly on the `Teacher` class, by using the extends keyword an instance of a Teacher shares has all of the same functionality of a newly created user.  We can also add new methods to a Teacher class that are not declared on a User.  For example, we can add a method called teachMath:

```js
class Teacher extends User {
  teachMath(){
    return `My name is ${this.name} and 1 + 1 is 2.`
  }
}

let tom = new Teacher("Tom", "tom@geocities.edu")
tom.sayHello()
// hello my name is Tom

tom.teachMath()
// My name is Tom and 1 + 1 is 2.

```

Here, we've *extended*, or inherited from `User` when creating the new `Teacher` class. We also added a new method `teachMath` that available to Teacher objects but is not available to User objects.  We can override an inherited method simply by defining another method with the same name.

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  sayHello() {
    console.log(`Hello, my name is ${this.name}`);
  }
}

class Teacher extends User {
  sayHello(){
    console.log('hello')
  }
}

let fred = new User('fred', 'fred@gmail.com')
fred.sayHello()
// Hello, my name is fred

let tom = new Teacher('tom', 'tom@gmail.com')
tom.sayHello()
// hello
```

Finally, we can add onto the functionality of a method with the `super` method.

```js
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  sayHello() {
    console.log(`Hello, my name is ${this.name}`);
  }
}


class Teacher extends User {
  sayHello(){
    super.sayHello()
    console.log('hello')
  }
}

tom.sayHello()
// Hello, my name is fred
// hello
```

If you look at the line `super.sayHello()`, what we're doing there is calling the `sayHello` method of the *superclass*, or the class (`User`) that our `Teacher` class inherits from. We wanted to preserve the behavior that was already there and then add to it, so rather than repeat the code, the `super` object gives us access to it programmatically.

## Summary

In this lesson, we explored the new `class` syntax of ES2015 and how to create and extend classes using it.

## Resources

+ [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)
+ [MDN: Classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)

