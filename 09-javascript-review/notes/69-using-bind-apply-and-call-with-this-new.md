# Bind, Call, and Apply Readme

## Objectives
1. Use `call()` and `apply()` to invoke a function with an explicit value for `this`
2. Explain the difference between `call()` and `apply()` in the way you pass arguments to the target function.
3. Use `bind()` to execute functions asynchronously

## Alternate Ways to Invoke Functions
In our exploration of `this`, we saw how it can change depending on how it is called.  Let's see a quick example:

```js
function greet() {
  console.log(`my name is ${this.name}, hi!`);
}
greet()
// "my name is , hi!"

let person = {
  name: 'bob',
  greet: greet
}

person.greet()
// my name is bob, hi!
```

As we see above, when the `greet` function is invoked as a function, `this` is the global scope.  However, when greet is invoked as a method of an object `this` changes to equal the object receiving the method call.  One thing we have yet to explore, is how Javascript allows us to set `this` to equal whatever we want.  Let's look at that.

```js
function greet() {
  console.log(`my name is ${this.name}, hi!`);
}

let sally = {name: 'sally'}

greet.apply(sally)
// my name is sally, hi!

greet.call(sally)
// my name is sally, hi!

```

As you see above, we can use `call()` or `apply()` to invoke a function with an explicit value for `this`.  So, instead of invoking the `greet()` function directly, we're invoking the `call()` method or the `apply()` method of the `greet` function.  And yes, our `greet` function can have a method, because in JavaScript functions are first class objects.   

So both `call` and `apply` give us a way to invoke a function and explicitly set `this` equal to the first argument of `call` or `apply`.  So then what's the difference between `call` and `apply`?

#### Passing Arguments With call() and apply()

The only real difference between `call` and `apply` is the way you pass arguments to the target function.

Let's modify our `greet` function to be a little friendlier:
```js

function greet(customerOne, customerTwo) {
  console.log(`Hi ${customerOne} and ${customerTwo}, my name is ${this.name}!`);
}
```

Now, when we invoke `greet`, not only do we need to explicitly set `this`, but we also need to pass values for `customerOne` and `customerTwo`.

Using `call`, we pass the object for `this` as the first argument, followed by any function arguments in order.

```js
let sally = {name: 'sally'}

function greet(customerOne, customerTwo) {
  console.log(`Hi ${customerOne} and ${customerTwo}, my name is ${this.name}!`);
}

greet.call(sally, "Terry", "George");
// Hi Terry and George, my name is sally!
```

Great! Now we see the name and the message! What happens if we don't pass any arguments?

```js
greet.call(sally);
// Hi undefined and undefined, my name is sally!
```

Okay, what about `apply`? So, this works very similar to `call`, except that `apply` only takes two arguments: the value of `this`, and then an *array* of arguments to pass to the target function. So to use `apply` with our new serve object, we'll need to pass that customer value inside an array.

```js
greet.apply(sally, ["Terry", "George"]);
// Hi Terry and George, my name is sally!
```

Very similar, but we need to wrap the arguments to the `greet` function in brackets to make it an array.  You can remember the difference because `apply` takes an **array** (both begin with the letter a).  You can use either `call` or `apply`.  The only difference is stylistic.

### bind()

So far, we have been looking at `call` and `apply`, which both explicitly set `this` and then immediately execute the function call.

Sometimes, however, we want to set the function's `this` value, but delay calling the function until later. For that, we use `bind()`.

Using `bind` is similar to `call` in that the first argument will be the value for `this` in the target function, then any arguments for the target function come in order after that.  However, when we use `bind`, we create a *new function* the same capabilities as our original function.  The only difference is that the copied function has the `this` value set, and we can execute that copied function whenever.

Try this out with our earlier example:

```js
let sally = {name: 'sally'}

function greet(customer) {
  console.log(`Hi ${customer}, my name is ${this.name}!`);
}

let newGreet = greet.bind(sally);

newGreet('Bob')
// Hi Bob, my name is sally!

greet('Bob')
// Hi Bob, my name is !
```

As you see from the above code, by calling `greet.bind(sally)` we return a new function that we then assign to the variable `newGreet`.  Invoking `newGreet` shows that the `this` object is bound to `sally`.  Note that the original `greet` function is unchanged, as shown by directly invoking our original `greet` function.  So `bind` does not change our original function.  Instead, it copies the function, and sets the copied function's `this` context to whatever is passed through as an argument to bind.  

Sometimes, `bind` is also to preserve `this` when invoked in a callback function.  Let's see this.

```js
class User {
  constructor(name, favoriteBand){
    this.name = name
    this.favoriteBand = favoriteBand
  }
  favoriteBandMatches(bands){
    bands.filter(function(band){
      return band == this.favoriteBand
    })
  }
}

let billy = new User('billy', 'paul simon')
billy.favoriteBandMatches(['paul simon', 'the kooks'])
// Uncaught TypeError: Cannot read property 'favoriteBand' of undefined
```

As you can see, the problem the code above runs into is that from inside the callback function, `this` becomes global.  To solve this, we can use `bind`.   

```js
class User {
  constructor(name, favoriteBand){
    this.name = name
    this.favoriteBand = favoriteBand
  }
  favoriteBandMatches(bands){
    // here this is the User instance
    bands.filter(function(band){
      // here, this is global
      return band == this.favoriteBand
    }.bind(this))
  }
}

let billy = new User('billy', 'paul simon')
billy.favoriteBandMatches(['paul simon', 'the kooks'])
// 'paul simon'
```

Let's see why the above code works.  The callback function is declared when the `favoriteBandMatches` method is invoked.  When the moment the method is invoked, `this` equals the user instance receiving the method call, and we bind the callback function to that user instance.  Then, from inside the `filter` method, the callback function is invoked - the context would be global here, except that the `this` is bound to `User` instance.

## Summary

We reviewed how `this` works for simple function calls. Then we saw how `call` and `apply` allow us to instantly execute functions while specifying the `this` value of the executed function.  Then we learned how to use `bind` to make copies of functions with a new `this` value bound to the copy of the function.

## Resources

- [MDN: Function.prototype.call()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)
- [MDN: Function.prototype.apply()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
- [MDN: Function.prototype.bind()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind)

