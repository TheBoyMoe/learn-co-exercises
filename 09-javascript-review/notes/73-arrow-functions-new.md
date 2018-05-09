JavaScript Arrow Functions
---

## Objectives

1. Practice writing arrow functions
2. Explain how arrow functions differ from named functions
3. Describe situations where arrow functions come in handy

## Function, function, function, function, function

You're familiar by now with the standard `function foo() { return 'bar' }` style of functions in JavaScript.
Well, there is another way to write functions in JavaScript called arrow functions:

``` javascript
// using our old standard function
const oldStandardFunction = function() {
  return "old standard functions rule!"
}


// updating to use an arrow function
const arrowFunction = () => {
  return 'Arrow functions are great!'
};
```

These are called [arrow functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) in reference to the little `=>` that characterizes them.

Arrow functions are invoked just like regular functions.

``` javascript
arrowFunction() // 'Arrow functions are great!'
```

Let's piece together how they work.

``` javascript
const arrowFunction = () => {
  return 'Arrow functions are great!'
};
```

Just like a regular function you've seen before, the body of an arrow function is declared inside the `{ }` brackets. The function parameters are declared in the parentheses before the arrow, which points to the body of the function.  

In a divergence from regular functions, if we omit the curly braces from around the function body (or replace them with parentheses), arrow functions give us implicit returns.  This only works if we write our arrow functions without brackets.

``` javascript
const square = (n) => (n * n)

square(3) // 9

const notSquare = (n) => { n * n }
notSquare(3)
// undefined

const backToSquared = (n) => { return n * n }
backToSquared(3)
// 9

```
## Anonymity's the Name of the Game

All arrow functions are anonymous. This is unlike regular functions, which take their names from their identifiers.

``` javascript
function iHaveAName() {}

iHaveAName.name // 'iHaveAName'
```

But arrow functions don't have identifiers, so they're always anonymous.

``` javascript
(() => {}).name // ''
```

We can set a pointer to an arrow function, or pass an arrow function through as an argument to another function:

```javascript
  const square = (n => n * n)
  // note that while the function is anonymous, we have assigned it to the variable 'square'

  [1, 2, 3].map(n => n * n)
  // [1, 4, 9]
  // The shorthand nature of arrow functions makes them useful for inline definitions

  [1, 2, 3].map(square)
  // [1, 4, 9]
```

It is important to remember that, in JavaScript, functions are 'first class objects'. They can be passed, declared, handled, and have properties and methods just like any other object.

We know that a function declaration (not invocation!) has a return value itself because we just assigned it to the variable `square` above. **The return value of a function declaration is a pointer to the function object itself.**

## Arrow Functions and 'this'

As we saw earlier, when a function is invoked from another function, the `context` or `this` value is global.  Let's see that again:

```js

  const person = {
    firstName: 'bob',
    greet: function() {
      return function reallyGreet() {
        return `Hi, I'm ${this.firstName}`
      }
    }
  }
  person.greet()()
  // Hi, I'm undefined
  // Here, we use two parentheses to invoke the returned function from person.greet()
```

As you can see, `this` does not know what `.firstName` is because it has reverted to global scope where `.firstName` is undefined. We see that the inner function is not in the same context as the `person` object. Assuming we want them to have access to the same context, (or `this` value), how can we fix this? In steps `bind`!

```js

const person = {
  firstName: 'bob',
  greet: function() {
    return function reallyGreet() {
      return `Hi, I'm ${this.firstName}`
    }.bind(this)
  }
}
person.greet()()
// Hi, I'm bob
// Here, we use two parentheses to invoke the returned function from person.greet()
```

As a quick review, in the above code, calling `person.greet()` executes the `greet` method which returns the `reallyGreet` function and binds the context of that function to `person`. Another way to achieve the same result of setting the inner function's context to `person` is with an arrow function.  If we use an arrow function, the inner function retains the scope of the method it was declared in.  Let's see it:

```js

  const person = {
    firstName: 'bob',
    greet: function() {
      return () => {
        return `Hi, I'm ${this.firstName}`
      }
    }
  }
  person.greet()()
  // "Hi, I'm bob"
```

As you can see, this inner arrow function retains the context of the outer `greet` method.  Just as the outer `greet` method's context is `person`, the inner function's context is also `person`. The arrow function has performed `.bind(this)` for us behind the scenes.

Let's see this same principle as it applies to callbacks. Both the following examples use an arrow function as the callback for `map`, but notice the different context:

```js

const person = {
  firstName: 'bob',
  greet: function() {
    return [1, 2, 3].map(() => this)
  }
}

person.greet()
// {firstName: "bob", greet: ƒ}
// {firstName: "bob", greet: ƒ}
// {firstName: "bob", greet: ƒ}

[1, 2, 3].map(() => this)
// window
// window
// window
```
In both cases, the arrow function retains the context that it is defined in. In the first case, the arrow function is defined in the `greet` method, where the `this` value references `person`.  Therefore, the `this` value within the arrow function is also `person`.  In the second case, the context within the arrow function is the global scope. Therefore, its `this` value is whatever the global scope is. In the case of the browser, `window`!

### Which is preferred

So which is better: an arrow function or a good old-fashioned function expression?  Drumroll, please... and the answer is, "Neither!"  They are different and each has its uses.  Arrow functions bring some nice advantages to the table, but they also have their limitations.  For example, arrow functions are not ideal for declaring object methods, as they will not pick up the object as the `this` context.  Also, arrow functions cannot be used as constructors.  As you build your JavaScript skills, you will develop a feel for when to use them.  Please make sure to explore the MDN resource listed below for further details.

### Summary

In the lesson above, we saw that arrow functions allow us to declare functions with minimal syntax. We saw that if we do not declare the function with brackets, then we do not need to provide an explicit return value to the function.  Finally, we saw that the `this` value of an arrow function is the same as the `this` value of its enclosing object.

## Resources

- [MDN: Arrow functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions)

