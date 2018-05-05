# Object Methods and Classes

## Objectives
+ Understand how to define a method for a particular object.
+ Understand how to call a method for a particular object.

## Introduction
So far we have spoken about how to use a constructor function to create objects with specific attributes.  For example, we can create a user with name and email attributes with the following code.

```js
function User (name, email){
  this.name = name;
  this.email = email;
}

let bob = new User('bob', 'bob@gmail.com')
// {name: 'bob', email: 'bob@gmail.com'}
bob.email
// bob@gmail.com
```

However, now that we know how to create objects with specific data, we may also want to endow our objects with behavior.  For example, say we would like to add the following behavior to our new user object:

```js
  bob.sayHello()
  // "Hello everybody!"
```

Let's try to write our constructor function in such a way that an instance of a user not only holds specific attributes, but also automatically gives objects created from it specific functions.

## Adding Methods to an Object

Let's start by just adding one a method to one object, that represents bob.  We begin with our existing code.

```js
function User (name, email){
  this.name = name;
  this.email = email;
}

let bob = new User('bob', 'bob@gmail.com')
// {name: 'bob', email: 'bob@gmail.com'}
```

Now let's assign our object `bob` a new attribute, `sayHello`, and point that attribute to a function.

```js
  bob.sayHello = function(){
    console.log('Hello everybody!')
  }

  bob.sayHello
    // function(){
      // console.log("Hello everybody!")
    // }

  bob.sayHello()
  // "Hello everybody!"
```

As the above code shows, if we call `bob.sayHello` it returns the function that we just declared, and if we decide to execute that function with the code `bob.sayHello()` it will log the string `Hello everybody`.  

Ok, so now let's move this code to our constructor function, such that every newly created object would have the ability to say `Hello everybody!`.  How do we do this?

Well, remember that we can refer to the newly created object from inside of our constructor function with the use of the word `this`.  So if we want to assign each new object a `sayHello` attribute that points to a specific function, we can write:

```js
function User (name, email){
  this.name = name;
  this.email = email;
  this.sayHello = function(){
    console.log("Hello everybody!");
  }
}

let susan = new User('susan', 'susan@gmail.com')

susan.sayHello()
// "Hello everybody!"


let fred = new User('fred', 'fred@gmail.com')
fred.sayHello()

// "Hello everybody!"
```

Great, so now we have a constructor function that returns objects with specific data, and that also adds behavior (in the form of methods) to those objects.

## Referencing data from a method call

Ok, so let's take this one step further.  Let's try to modify our constructor function such that when we invoke the function it also references the name attribute of the object being called.

```js
fred.sayHello()
// "Hello everybody, my name is Fred!"

susan.sayHello()
// "Hello everybody, my name is Susan!"
```

How would we do this?  Let's look at the constructor function as it stands now.

```js
function User (name, email){
  this.name = name;
  this.email = email;
  this.sayHello = function(){
    console.log("Hello everybody!");
  }
}
```

So how do we reference the object whose method's being called's data?  With the `this` object again.  We'll take a deep dive into `this` in a couple lessons, but for now, let's finish up with our functionality.

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
// "Hello everybody, my name is fred!"

let bob = new User('bob', 'bob@gmail.com')
// "Hello everybody, my name is bob!"
```

So how did this all come together?  We put together our knowledge that when create an object with a constructor function, `this` refers to that newly created object.  Then we used that knowledge to assign each newly created object an attribute of `sayHello` that points to a function.  Finally, we had that method reference data specific to it's object with use of `this`.      

## Summary

In this lesson, we've learned the differences between methods and functions, and seen how to add methods to objects through the constructor function.  Now, let's put this new knowledge to practice.

## Resources

+ [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

