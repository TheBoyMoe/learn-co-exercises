# First-Class Functions

## Objectives
1. Explain the difference between a _statement_ and an _expression_.
2. Use _function expressions_ instead of _function declarations_ and understand the differences.
3. Understand that functions are special objects that — among many other things — can be stored in variables and other data structures, can contain key-value pairs (properties), and can be passed to and returned from other functions.
4. Recognize an _IIFE_ and break down what's going on with its unusual syntax: `(function () {})()`

## Statements vs. expressions
Before we dive headlong into functions, let's take a minute to talk about the fundamental building blocks of JavaScript code: _expressions_ and _statements_. A _statement_ is a unit of code that accomplishes something but **does not produce a value**. An _expression_ is a unit of code that **produces a value**.

Many of the common keywords we've encountered form _statements_:
- Variable declarations: `const`, `let`, `var`
- Iteration: `for`, `for...in`, `for...of`, `while`
- Control flow: `if...else`, `switch`, `break`
- Debugging: `debugger`

All of those keywords are extremely useful, but none of them generate a value on their own. Take this `if` statement:
```js
if (true) {
  6 + 9;
}
```

The expression inside of the `if` statement, `6 + 9`, produces a value: the number `15`. The `if` statement itself, however, produces no value. We can assign the expression `6 + 9` to a variable, but we can't assign that `if` statement to one:
```js
const myVar = 6 + 9;

myVar;
// => 15

const myOtherVar = if (true) { 6 + 9; };
// ERROR: Uncaught SyntaxError: Unexpected token if
```

That `Unexpected token` error message is JavaScript telling us, "Hey, that keyword is for creating statements — stop trying to use it as though it's an expression!" A few more examples:
```js
const myVar = debugger;
// ERROR: Uncaught SyntaxError: Unexpected token debugger

const myVar = const myOtherVar = 6 + 9;
// ERROR: Uncaught SyntaxError: Unexpected token const

const myVar = while (true) { 6 + 9; };
// ERROR: Uncaught SyntaxError: Unexpected token while
```

***Top Tip***: If you're struggling a bit with the difference between a statement and an expression, let's try thinking about it in a slightly different way. Statements can be used to hold data (`const`, `let`, `var`), iterate over data (`for`, `for...in`, `for...of`, `while`), control the flow of data (`if...else`, `switch`, `break`), and debug data (`debugger`). Contrast that with expressions, which **produce** data. A JavaScript program is effectively a series of statements that control, organize, and structure a series of expressions.

If you're still having some trouble with the distinction, there's an excellent blog post by Dr. Axel Rauschmayer linked at the bottom of this lesson. But what does all of this stuff about expressions and statements have to do with functions?

## Function expressions
When we first learned about functions, we learned about _function declarations_, which are a type of statement. That is, when we declare a function in the standard way, it does not produce a value:
```js
function myFunc () {}
```

However, the `function` keyword is adaptable. When it's the first thing in a line of code, it forms a _function declaration_ that creates a new function in memory but does not immediately produce a value. When it's placed anywhere except at the start of a line, it forms a _function expression_ that creates a new function **and** immediately returns that function as a value:
```js
(function () {})
// => ƒ () {}
```

String literals result in new strings, array literals result in new arrays, object literals result in new objects, and function expressions result in new functions:
```js
'Hello, world!'
// => "Hello, world!"

[]
// => []

{}
// => {}

(function () {})
// => ƒ () {}
```

***NOTE***: The parentheses surrounding the above anonymous function are so that the `function` keyword isn't the first thing in the line of code. Parentheses used in this way are the _grouping operator_ (as in `2 * (3 + 4)`), and they don't affect the value produced by the expression:
```js
(((((((((('Hello, ')))))))))) + (((((((((('world!'))))))))))
// => "Hello, world!"
```

Parentheses around a function expression are **only required if the function keyword would otherwise be the first thing in a line of code**.

Okay, great, so we can create functions with function expressions. So what?


## Functions are objects
In JavaScript, functions are what's known as _[first-class citizens][wiki]_ of the language. That means functions have the following four abilities:
- A function can be assigned to a variable.
- A function can be stored in a data structure.
- A function can be the return value of another function.
- A function can be passed as an argument to another function.

In a previous lesson, we told you to start thinking about functions as objects because, well, they are. **A JavaScript function is simply a JavaScript object with a few added goodies**. That means that **everything we can do to an object can also be done to a function**.

### Assigning functions to variables
A function expression results in a function. Just like we can store an object in a variable, we can also store a function in a variable:
```js
const myObj = {};

const myFunc = function () {
  return 6 + 9;
};
```

Since the result of the function expression is a function object, that variable now contains a function. What can we do to functions? We can invoke them!

```js
myFunc();
// => 15
```

#### Function expressions and hoisting
One thing to note when you're debating whether to use a function declaration or a function expression stored in a variable: **function expressions are not hoisted**. Remember, hoisting is the somewhat ill-fitting name for the process whereby the JavaScript engine stores function (and variable) declarations in memory during the compilation phase. Since they're already stored in memory by the time the execution phase starts, we can refer those 'hoisted' functions before their lexical declaration — that is, above where they're written in the code:
```js
sayHi();

function sayHi () {
  console.log('Hi');
}
```

The above code works perfectly fine. Try it out in your browser's console. Contrastingly, function expressions are not hoisted. The JavaScript engine ignores them during the compilation phase, instead evaluating them during the execution phase. The following code will result in an error because variables declared with `const` aren't hoisted:
```js
sayHello();

const sayHello = function () {
  console.log('Hello');
};
// ERROR: Uncaught ReferenceError: sayHello is not defined
```

Even if we use the dreaded `var`, the variable declaration will be hoisted but the assignment — where the function is instantiated and assigned to the variable — doesn't happen until the execution phase. Therefore we see a different error, this one telling us that `sayHello` is not a function:
```js
sayHello();

var sayHello = function () {
  console.log('Hello');
};
// ERROR: Uncaught TypeError: sayHello is not a function
```

The `sayHello` variable is hoisted this time, but it contains `undefined` until the assignment line is reached. We can't invoke `undefined`, so `sayHello()` throws an error.

***Top Tip***: Storing a function expression in a `const`-declared variable is a good default strategy. We get all of the intelligent scoping behavior provided by `const`, allowing us much more intuitive control over when and where the function is available for use.

#### Passing by reference
Like all JavaScript objects, functions are passed _by reference_. When a new function is created, it's stored at a specific location in memory. When we assign a function expression to a variable, we're not actually storing the entire function in that variable — we're simply storing a reference to the location in memory where the function lives. If we assign the value of that first variable to a new variable, the new variable also points at the same location in memory:
```js
const original = function () {
  console.log("I'm the original!");
};

const copy = original;

copy();
// LOG: I'm the original!
```

If we modify the function, we're changing the object in memory, so every reference to the function will see the modifications:
```js
copy.newProperty = "I'm a new property!";

original.newProperty;
// => "I'm a new property!"
```

However, if we simply reassign the variable to a new function, it no longer points at the same location in memory:
```js
let original = function () {
  console.log("I'm the original!");
};

const copy = original;

original = function () {
  console.log("I'm a new function!");
};

copy();
// LOG: I'm the original!

original();
// LOG: I'm a new function!
```

<picture>
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_2.webp" type="image/webp">
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_2.gif" type="image/gif">
  <img src="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_2.gif" alt="Vince McMahon is interested.">
</picture>

### Adding properties to a function
Since a function is just a special object, we can add properties to functions and then access them:
```js
const myFunc = function () {
  return 6 + 9;
};

myFunc.favoriteNumber = 42;
// => 42

console.log("myFunc()'s favorite number is", myFunc.favoriteNumber);
// LOG: myFunc()'s favorite number is 42
```


### Storing functions in an array
We can store functions as elements in an array:
```js
const arrayOfObjects = [
  { name: 'Sandi Metz' },
  { name: 'Anita Borg' },
  { name: 'Ada Lovelace' }
];

const arrayOfFunctions = [
  function () { console.log('Functions'); },
  function () { console.log('are'); },
  function () { console.log('so'); },
  function () { console.log('cool!'); }
];
```

When we access the various indexes in our array, we're retrieving those stored functions:
```js
arrayOfFunctions[0];
// => ƒ () { console.log('Functions'); }

arrayOfFunctions[3];
// => ƒ () { console.log('cool!'); }
```

And, one more time, what's that fun thing we can do to any function? We can invoke it! How do we invoke it? With the invocation operator:
```js
arrayOfFunctions[0]();
// LOG: Functions
arrayOfFunctions[1]();
// LOG: are
arrayOfFunctions[2]();
// LOG: so
arrayOfFunctions[3]();
// LOG: cool!

for (const fn of arrayOfFunctions) {
  fn();
}
// LOG: Functions
// LOG: are
// LOG: so
// LOG: cool!
```

<picture>
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_4.webp" type="image/webp">
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_4.gif" type="image/gif">
  <img src="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_4.gif" alt="Vince McMahon is intrigued.">
</picture>

### Storing functions in objects
We can also store functions as properties of an object:
```js
const ada = {
  fullName: 'Ada Lovelace',
  greet: function (name) {
    console.log(`Hi there ${name}, I'm Ada Lovelace.`);
  },
  claimToFame: function () {
    console.log('I was the first computer programmer.');
  }
};

ada.fullName;
// => "Ada Lovelace"

ada.greet;
// => ƒ (name) { console.log(`Hi there ${name}, I'm Ada Lovelace.`); }

ada.greet();
// LOG: Hi there undefined, I'm Ada Lovelace.

ada.greet('Vince');
// LOG: Hi there Vince, I'm Ada Lovelace.

ada.claimToFame();
// LOG: I was the first computer programmer.
```

***NOTE***: When a function is stored in an object, we call it a _method_. It's also still a function, of course — methods are a subset of functions. We'll go much deeper into this in the lessons on object-oriented JavaScript, but keep the terminology in mind. A good rule of thumb: if you need to use the dot operator to invoke the function (as in `ada.greet()` instead of simply `greet()`), it's a method. For a common example, think of `console.log()`. We're invoking the `log()` method on the `console` object.

<picture>
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_5.webp" type="image/webp">
  <source srcset="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_5.gif" type="image/gif">
  <img src="https://curriculum-content.s3.amazonaws.com/web-development/js/advanced-functions/first-class-functions-readme/vince_mcmahon_5.gif" alt="Vince McMahon is startled.">
</picture>

### Returning functions from functions
Functions can return any kind of data: strings, numbers, objects... you name it. Well, since functions are themselves merely objects, what's stopping us from returning a function from a function? Nothing! Here we create a function that assembles and returns other functions:
```js
const createDivisibleFunction = function (divisor) {
  return function (num) {
    return num % divisor === 0;
  };
};
```

Then let's store the returned functions in variables so that we can reference and invoke them:
```js
const divisibleBy3 = createDivisibleFunction(3);

const divisibleBy5 = createDivisibleFunction(5);

divisibleBy3;
// => ƒ (num) { return num % divisor === 0; }

divisibleBy5;
// => ƒ (num) { return num % divisor === 0; }

divisibleBy3(9);
// => true

divisibleBy3(10);
// => false

divisibleBy5(9);
// => false

divisibleBy5(10);
// => true
```

***Top Tip***: In a situation where we need a lot of similar but slightly different functions, this is a great pattern for cutting down on repetitive code. Instead of declaring 100 different functions, we can declare a single function and invoke it 100 times, passing in different arguments each time. We'll still end up with the same 100 functions, but we drastically reduced the amount of code we had to write.

#### It's turtles all the way down
There's nothing stopping us at a function that returns a function, though. How about a function that returns a function that returns a function that returns a... well, you get the idea:
```js
const howManyLicks = function () {
  return function () {
    return function () {
      return function () {
        return function () {
          return function () {
            return function () {
              return function () {
                return function () {
                  return function () {
                    console.log('does it take to get to the Tootsie Roll center of a Tootsie Pop?');
                  };
                };
              };
            };
          };
        };
      };
    };
  };
};
```

When we invoke the function stored inside the `howManyLicks` variable, it returns another function:
```js
howManyLicks();
// => ƒ () { return function () { return function () { return function () { ...
```

One lick down, nine more to go. When we invoke the function returned by the invocation of the first function, we get **another** function:
```js
howManyLicks()();
// => ƒ () { return function () { return function () { return function () { ...
```

We can continue in this manner all the way down the nested functions:
```js
howManyLicks()()()()();
// => ƒ () { return function () { return function () { return function () { ...

howManyLicks()()()()()()();
// => ƒ () { return function () { return function () { console.log('does it ...
```

Until, finally, we reach the center:
```js
howManyLicks()()()()()()()()();
// => ƒ () { console.log('does it take to get to the Tootsie Roll center of ...

howManyLicks()()()()()()()()()();
// LOG: does it take to get to the Tootsie Roll center of a Tootsie Pop?
```

Please don't ever do this in your actual code. The deeply nested example is simply meant to familiarize ourselves with the combination of these ideas:
1. We can invoke functions.
2. Functions can return other functions.
3. When a function returns another function, we can invoke its return value **because it's a function**!


### Functions passed as arguments
We already encountered this during the introduction to callback functions, but the concept is important enough to reiterate here: **functions can be passed into other functions as arguments**. Take a look at the following example:
```js
function hid (fn) {
  console.log('Inside hid()');

  return fn;
}

const den = function (fn) {
  console.log('Inside den()');

  return fn;
};

function mess (cb) {
  console.log('Inside mess()');

  cb();
}

const age = function () {
  console.log('Inside age()');
};

hid(den)(mess)(age);
// LOG: Inside hid()
// LOG: Inside den()
// LOG: Inside mess()
// LOG: Inside age()
```

The final line, `hid(den)(mess)(age)`, looks super weird, but let's break it down. First, we invoke the `hid()` function, and we pass the value stored in the `den` variable in as the lone argument: `hid(den)`. An anonymous function is stored in `den`, and all `hid()` does is return the passed-in argument. If we stop there, the return value of `hid(den)` is the function stored in `den`:
```js
hid(den);
// LOG: Inside hid()
// => ƒ (fn) { console.log('Inside den()'); return fn; }
```

So invoking `hid(den)` logs out the first message and then returns a function. The returned function accepts one argument, logs out a second message, and then returns the passed-in argument. What do we like to do with functions? Invoke 'em! Invoking `hid(den)()` would do the trick, but let's also pass in another function as the `fn` parameter:
```js
hid(den)(mess);
// LOG: Inside hid()
// LOG: Inside den()
// => ƒ mess (cb) { console.log('Inside mess()'); cb(); }
```

And right on cue, it returns another function! This one also accepts a single argument, then logs out a message, and finally invokes the passed-in argument. If we invoke the returned function without passing an argument, we get a pretty descriptive error:
```js
hid(den)(mess)();
// LOG: Inside hid()
// LOG: Inside den()
// LOG: Inside mess()
// ERROR: Uncaught TypeError: cb is not a function
//          at mess (<anonymous>:16:3)
//          at <anonymous>:1:15
```

Since we didn't pass any arguments, the `cb` parameter inside `mess()` contained `undefined`. And when the JavaScript engine hit the `cb()` line inside `mess()`, it yelled at us: "Hey, `cb` doesn't contain a function — it contains `undefined`. I can't invoke this!" When we pass in a function, such as `age()`, everything works swimmingly:
```js
hid(den)(mess)(age);
// LOG: Inside hid()
// LOG: Inside den()
// LOG: Inside mess()
// LOG: Inside age()
```


## Immediately-invoked function expressions
An _immediately-invoked function expression_ (usually abbreviated to _IIFE_) is exactly what it says on the tin: it's a function expression that we invoke immediately. Here's a function expression that returns a function object:
```js
(function () { console.log("Help, I've been invoked!") });
// => ƒ () { console.log("Help, I've been invoked!") }
```

What can we do with that returned function object? We can invoke it... immediately:
```js
(function () { console.log("Help, I've been invoked!") })();
// LOG: Help, I've been invoked!
```

We can pass arguments into the invocation operator just like any old function:
```js
(function (name, year, claimToFame) {
  console.log(`Hi, I'm ${name}, I was born in ${year}, and I ${claimToFame}!`);
})('Ada Lovelace', 1815, 'was the first computer programmer');
// LOG: Hi, I'm Ada Lovelace, and I was the first computer programmer!

(function (name, year, claimToFame) {
  console.log(`Hi, I'm ${name}, I was born in ${year}, and I ${claimToFame}!`);
})('Grace Hopper', 1906, 'invented one of the first compilers');
// LOG: Hi, I'm Grace Hopper, and I invented one of the first compilers!
```

We won't be using IIFEs much until we introduce _closures_, but it's an ubiquitous construct that you're sure to come across when searching StackOverflow and other resources.

## Anonymous function expressions
We mentioned this in a previous lesson as well, but now we can put some more definite terms behind the concept. A function declaration **must** have a name; the JavaScript engine requires that we assign it an identifier that we can then use to refer to the function object in memory. Forgoing the name results in the following error message:
```js
function () {}
// ERROR: Uncaught SyntaxError: Unexpected token (
```

The engine is saying, "Hey, I expected to see an identifier after the `function` keyword, but all I found was this silly parenthesis. That's not the start of a valid identifier!"

However, there's no such constraint on function expressions. You can add a name if you want:
```js
(function namedFunctionExpression1 () {})
// => ƒ namedFunctionExpression1() {}

const myFunc = function namedFunctionExpression2 () {};

myFunc;
// => ƒ namedFunctionExpression2() {}
```

But it isn't necessary:
```js
(function () {})
// => ƒ () {}

const myFunc = function () {};

myFunc;
// => ƒ () {}
```

Most of the time, an anonymous function expression will suffice. It's a bit easier to read and keeps our code less cluttered. That being said, there's one main benefit to naming your function expressions: better stack traces. This anonymous stack trace doesn't give us a lot to go on:
```js
(function () { thisWillThrowAnError; })();
// ERROR: Uncaught ReferenceError: thisWillThrowAnError is not defined
//          at <anonymous>:1:16
//          at <anonymous>:1:40
```

This one includes the function expression's name and is consequently a bit easier to locate and debug:
```js
(function nowWithAName () { thisWillThrowAnError; })();
// ERROR: Uncaught ReferenceError: thisWillThrowAnError is not defined
//          at nowWithAName (<anonymous>:1:29)
//          at <anonymous>:1:53
```

## Conclusion
This lesson introduces a ton of new things to think about when dealing with functions in JavaScript, but you're hopefully starting to see just how powerful functions are. We'll be discussing many of these new concepts in greater depth as we continue to explore the JavaScript language. It's important that you practice and familiarize yourself with these fundamental ideas because they are the building blocks that we'll expand on and compose into increasingly complex and powerful patterns.

## Resources

- [Wikipedia — First-class function][wiki]
- [StackOverflow — What is meant by 'first class object'?][stackoverflow]
- [Helephant — Functions are first class objects in javascript (Wayback Machine)][helephant]
- [2ality — Expressions versus statements in JavaScript][2ality]
- [MDN — Statements and declarations][mdn]

[wiki]: https://en.wikipedia.org/wiki/First-class_function
[stackoverflow]: https://stackoverflow.com/questions/705173/what-is-meant-by-first-class-object
[helephant]: https://web.archive.org/web/20170606141950/http://helephant.com/2008/08/19/functions-are-first-class-objects-in-javascript/
[2ality]: http://2ality.com/2012/09/expressions-vs-statements.html
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements

