# Using Prototypes

## Objectives
+ Understand how prototypes reduce the memory footprint of our objects.
+ Understand how to define a method on the prototype of a constructor function.
+ Understand how those methods can be executed on objects constructed from that function.

### A problem we didn't know we had

We ended our lesson on constructing objects from a constructor function with the following code.

```js
function User (name, email){
  this.name = name;
  this.email = email;
  this.sayHello = function(){
    console.log(`Hello everybody, my name is ${this.name}!`);
  }
}

let lauren = new User('lauren', 'lauren@gmail.com')
lauren.sayHello()
// "Hello everybody, my name is lauren!"

let fred = new User('fred', 'fred@gmail.com')
fred.sayHello()
// "Hello everybody, my name is fred!"
```

This code works well, but we are not being very efficient.  Let's see how.

```js
  lauren.sayHello
  // function(){
  //   console.log(`Hello everybody, my name is ${this.name}!`);
  // }

  fred.sayHello
  // function(){
  //   console.log(`Hello everybody, my name is ${this.name}!`);
  // }
```

Both lauren and fred have a `sayHello` property that points to a seemingly identical function.  But are these two objects pointing to the same function? No.

```js
  lauren.sayHello == fred.sayHello
  // false
```

Think about why this is true.  Every time that we instantiate a new object, we run our constructor function, which declares a new function as a property of the new object.

```js
function User (name, email){
  this.name = name;
  this.email = email;
  this.sayHello = function(){
    console.log(`Hello everybody, my name is ${this.name}!`);
  }
}
```

The problem is that all of these functions are precisely the same.  They only return different values because the value of `this` is dependent on the object whose method is being called.  Well if we declare a new, yet identical function for every instance of a constructor we are being memory inefficient.  That is, each instance of our object would be a different, yet identical, method attached to it.  And in JavaScript, where our code needs to run in a memory-limited browser, this is something we would prefer to avoid. So what we want is a way to declare the function just one time, yet grant each object made from our constructor function a reference to this function.

### Behold the Prototype!!

Javascript objects have something called a Prototype.  Let's check it out.

```js
function User(name, email) {
  this.name = name;
  this.email = email;
}

User.prototype.sayHello = function() {
  console.log(`Hello everybody, my name is ${this.name}`);
}

var sarah = new User("sarah", "sarah@aol.com");

sarah.sayHello();
// "Hello everybody, my name is sarah!"
```

Let's reflect on what we just did.  We moved our declaration of the `sayHello` function to outside of the constructor function `User`.  This prevents the `sayHello` function from being redeclared each time a new user is created.  However, we do want to give each constructed user object access to this function.  To do so, we access the User function's prototype property.  What is a prototype?

```js
  User.prototype
  // {}
  typeof User.prototype
  // object
```  

It's just a JavaScript object.  That object can store specific attributes.  The key point is that every new user instance made from the User constructor function has reference to attributes defined on User function's  prototype object.  So this lends to the following:


```js

  function User(name, email) {
    this.name = name;
    this.email = email;
  }

  User.prototype
  // {}

  User.prototype.sayHello = function(){
    console.log(`Hello everybody, my name is ${this.name}`);
  }

  let sarah = new User('sarah', 'sarah@gmail.com')

  sarah.sayHello()
  // "Hello everybody, my name is sarah!"

  let freddy = new User('freddy', 'freddy@gmail.com')
  freddy.sayHello()
  // "Hello everybody, my name is freddy!"

  freddy.sayHello == sarah.sayHello
  // true
```

What the above code illustrates is each JavaScript object has reference to attributes declared on its constructor's prototype.  So both `sally` and `freddy` have reference to the `sayHello` attribute that points to a specific function.  Not only that, but they have reference to **exactly the same function**.  So regardless of the number of objects produced from the `User` constructor, there will be only one declared `sayHello` function.  

Going forward with constructor functions, it's best to separate our code as we did here.

```js
function User(name, email) {
  this.name = name;
  this.email = email;
}

User.prototype.sayHello = function() {
  console.log(`Hello everybody, my name is ${this.name}`);
}

let sarah = new User('sarah', 'sarah@gmail.com')
```

As you can see, we keep the assignment of properties that point to data inside the function. This makes sense, as these pieces of data are different for each object.  However we move the assignment of properties that point to functions outside of constructor function and onto the constructor's prototype.  This is because unlike the properties pointing to data, these methods are identical between instances of the same constructor.  

### Summary

In this section, we saw how we can use prototypes to avoid redeclaring identical functions.  We saw that even though we are only declaring the function one time, with the use of a prototype each constructed object has access to the functions defined on its constructor's prototype.
