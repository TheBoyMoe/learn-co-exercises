# Errors and Stack Traces

## Overview
In this lesson, we'll introduce some of the common types of errors you'll encounter when writing JavaScript code.

## Objectives
1. Recognize common JavaScript errors.
2. Read a stack trace to discern where an error originated.

## Introduction
No one writes perfect code the first time. Or the second time. Or the third time.

We all make mistakes. One of the biggest advantages an experienced programmer has is knowing how to quickly troubleshoot and fix errors they encounter. You **will** reach this point — it's just a matter of practice. To get you started, let's look at some of the common types of error messages you'll encounter when writing JavaScript code.

## `Uncaught ReferenceError: _____ is not defined`
This is one of the simplest and most common errors, and it's pretty explicitly telling us what went wrong. We tried to reference a variable or function that doesn't exist in the current scope (or in the scope chain)! For example:
```js
myVar;
// ERROR: Uncaught ReferenceError: myVar is not defined
```

It can also arise if you forget to put quotation marks around a string:
```js
Hello, world
// ERROR: Uncaught ReferenceError: Hello is not defined

'Hello, world'
// => "Hello, world"
```

If you meant to declare the variable in the current scope and simply forgot, declaring the variable should solve the issue:
```js
const myVar = 'Hello, world!';

myVar;
// => "Hello, world!"
```

The more difficult case is when you expected the variable to exist in the scope chain — that is, you expected the variable to have been declared in an outer scope and therefore to be accessible inside your function. You'll get better at recognizing and debugging this case with practice. For now, double check where the current function is declared. Make sure it's declared at a place where its scope chain should include the outer scope that contains the declaration of the variable you're trying to access.

## `Uncaught TypeError: _____ is not a function`
This one usually indicates that you tried to invoke something that isn't actually a function. For example:
```js
const myVar = 'Hello, world!';

myVar();
// ERROR: Uncaught TypeError: myVar is not a function
```

A common one that you'll run into when we get into asynchronous programming in JavaScript is `Uncaught TypeError: undefined is not a function`. The JavaScript engine is telling us that we tried to invoke `undefined`, which is obviously not invocable. It typically happens when a variable contains `undefined` instead of a function. The way to debug it is to find where the attempted invocation happened and then figure out why that variable contains `undefined`.

## `Uncaught SyntaxError: missing ) after argument list`
When you see this error, it means you tried to invoke a function but forgot the closing parenthesis:
```js
console.log('Hello,', 'world!';
// ERROR: Uncaught SyntaxError: missing ) after argument list

function myAdder (num1, num2) {
  return num1 + num2;
}

myAdder(10, 4;
// ERROR: Uncaught SyntaxError: missing ) after argument list
```

## `Uncaught TypeError: Assignment to constant variable.`
You're probably familiar with this one by now — it means we accidentally tried to assign a new value to a variable declared with the `const` keyword, which prevents reassignment. However, sometimes you rightfully feel that you didn't try to reassign anything, and it boils down to a small typo:
```js
const snackSelection = 'Pretzels';

if (snackSelection = 'Pretzels') {
  console.log("That'll be $1, please!");
}
// ERROR: Uncaught TypeError: Assignment to constant variable.
```

In this case, we accidentally used the _assignment operator_, a single `=` sign, instead of a comparison operator, such as the triple equals (`===`) _strict equality operator_.

This is just a selection of some of the many types of errors you might encounter while writing JavaScript code. The main point is to use the information you're given. The JavaScript engine isn't trying to trick you — on the contrary, it's trying to **help** you debug.

## Stack traces
One of the really neat pieces of information provided with the error messages is what's called a _stack trace_. If you've been following along with the examples in the JS console, you've probably already seen something like this:
```js
const snackSelection = 'Pretzels';

if (snackSelection = 'Pretzels') {
  console.log("That'll be $1, please!");
}
// ERROR: Uncaught TypeError: Assignment to constant variable.    VM5412:3
//           at <anonymous>:3:20
//        (anonymous) @ VM5412:3
```

At first glance, that's the kind of error message that makes a programmer new to JavaScript run screaming in the opposite direction. So many random numbers! What the heck are `<anonymous>` and `(anonymous)`?! `VM5412:3` looks like the name of R2-D2's cousin!

All of this strange information is telling us the same thing: the exact location of where the error occurred. We're not going to go too deep into it, but `VM` standards for _Virtual Machine_, and it's Chrome's way of saying that the script didn't run in a specific file. In this case, the script ran in the JavaScript console, and Chrome arbitrarily assigned an ID of `5412` to the execution of that particular script. If you're coding along — which you should be! — the number in your console is most likely different. If you run the same code again, the number will have changed because Chrome's treating it as a new script execution and will assign it a new ID number.

The `:3` piece of `VM5412:3` is, however, interesting. It's telling us which **line** within the script caused the error. In this case, it happened on the third line.

The `at <anonymous>:3:20` message elaborates on the `:3`, indicating that, not only was the error on the third line, it was on the 20th **character** of the third line. The `<anonymous>` is, like the `VM` designation, telling us that the error didn't occur in a specific file.

The only new piece of information on the final line is `(anonymous)`, which is slightly different from the `<anonymous>` above. While `<anonymous>` indicates that we aren't in a particular file, `(anonymous)` tells us that we're in the global scope — that the error didn't occur inside of a function.

To get a better sense of the various pieces of information provided in the error message, let's take a look at a couple errors in a JavaScript file. That way, we won't have (most of) this `<anonymous>` garbage to further confuse us.

### `index.html` and `errors.js`
Open up `index.html` in your browser.

***NOTE***: If you're in the IDE, follow [these steps](http://help.learn.co/the-learn-ide/common-ide-questions/viewing-html-pages-in-the-learn-ide). For local environments, there are a ton of different ways to do this. It will vary based on your operating system, but double clicking on the file in your file system should work on every OS. On macOS, you can type `open index.html` in the lesson's directory in your terminal. On Linux, the equivalent command is likely `xdg-open index.html`, and on Windows it should be `start index.html`.

When the file's open in your browser, open the JS console, and you should see something similar to the following error:

![Assignment to constant variable](https://curriculum-content.s3.amazonaws.com/web-development/js/principles/errors-and-stack-traces-readme/assignment_to_constant_variable.png)

Whoa, that's so much easier to understand! It's telling us the error occurred on line `5` in `errors.js`. Let's see what's on line 5 of the file:
```js
if (snackSelection = 'Pretzels') {
```

Ah, it's the same error from before: we've accidentally used the assignment operator instead of the strict equality operator. Let's fix it:
```js
if (snackSelection === 'Pretzels') {
```

Save the `errors.js` file after you've made the fix, and refresh the browser window. You should see two things in the console, the `That'll be $1, please!` message from the first code snippet and a new error telling us that `third` is not defined:

![Assignment to constant variable](https://curriculum-content.s3.amazonaws.com/web-development/js/principles/errors-and-stack-traces-readme/third_is_not_defined.png)

Let's see what's on lines `17`, `13`, and `20` in `errors.js`:

```javascript
const snackSelection = 'Pretzels';

if (snackSelection = 'Pretzels') {
    console.log("That'll be $1, please!");
}


// Fix the code above this line to see the error from this first() function in your browser's console

function first () {
    second();
}

function second () {
    third();
}

first();
```

Now that we're dealing with a series of function invocations, we can really see the power of the stack trace: it _traces_ the error up through the _stack_ of function calls that led to it. Let's read it backwards and reconstruct the events that led to the error:
1. In the global scope: the JavaScript engine reaches line `20` and invokes `first()`.
2. Inside `first()`: the engine reaches line `13` and invokes `second()`.
3. Inside `second()`: the engine reaches line `17` and sees the identifier `third`, but it can't find a declared variable or function with that name in the current scope (`second()`) or the outer scope (the global scope).
4. Because it can't find a matching declaration, the JavaScript engine throws an error inside `second()` that then propagates up the call stack until it reaches the global execution context.

To fix the `third is not defined` error, let's first try declaring `third` as the simplest thing we know, a variable:
```js
function first () {
  second();
}

function second () {
  third();
}

const third = 'Declaring a new variable.';

first();
```

Remember what we learned earlier in the section on common JavaScript errors. If our understanding is correct, this should fix the `third is not defined` error and, in its place, throw a new error. Can you guess what the new error will be?

![`third is not a function`](https://curriculum-content.s3.amazonaws.com/web-development/js/principles/errors-and-stack-traces-readme/third_is_not_a_function.png)

The new error is telling us that `third is not a function`. It may have been pretty obvious that our initial solution would just result in another error — after all, the code we're working with isn't all that complicated. However, intentionally breaking your code and seeing whether it breaks in the exact way you predicted is a great technique for improving your debugging and general JavaScript skills. The more you understand the errors and their causes, the easier debugging will become.

The fix, of course, is to declare `third()` as a function instead of a simple variable:
```js
function first () {
  second();
}

function second () {
  third();
}

function third () {
  console.log("Now I'm a function!");
}

first();
```

When we save the file and refresh the page again, all of the errors should be gone:

![No more errors](https://curriculum-content.s3.amazonaws.com/web-development/js/principles/errors-and-stack-traces-readme/no_more_errors.png)

## Playing `catch` with JavaScript errors
We mentioned earlier that an error thrown in a function "propagates up the call stack until it reaches the global execution context." But why?

The reason thrown errors propagate up the call stack is that the JavaScript engine is looking for something to _catch_ the error. This is getting back to why all of the error messages we've seen so far are _uncaught_ errors.

JavaScript provides a control flow structure called `try...catch` with which you can `try` to run some JavaScript statements and `catch` any errors thrown within the `try` block. We aren't going to go into any greater depth on the topic because it isn't worth getting sidetracked. If you **really** want to learn more about handling errors with a `try...catch` statement, check out the [MDN reference][try...catch]. You'll probably encounter `try...catch` in the wild, but it's often not the best tool for the job. By design, it's a performance nightmare to rely on your code throwing errors as a control flow pattern. It's much better to make your code flexible and properly handle things like bad user input **without** throwing errors. Errors should be reserved for when something goes seriously wrong.

## Conclusion
Arguably the biggest difference between being a novice and an expert developer is how comfortable you feel with reading and debugging error messages. JavaScript — and, indeed, every programming language — is designed **by** programmers **for** programmers. The language doesn't intentionally make things more difficult for you. On the contrary, every time you write code that results in some sort of error, JavaScript goes out of its way to provide you with the information you need to find and fix the error. When you see one of those bright red error messages pop up, don't freak out! It's the JavaScript engine starting a friendly dialog with you: "Hey, I tried to do what you asked of me, but I ran into a problem. Here's where the problem occurred, and here's what happened."

As you become more comfortable diagnosing and solving error messages, you'll become a faster, better programmer, and writing JavaScript code will become more and more enjoyable!

## Resources
- [MDN — Errors](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors)
  + [`Uncaught ReferenceError: _____ is not defined`][x is not defined]
  + [`Uncaught TypeError: _____ is not a function`][x is not a function]
  + [`Uncaught SyntaxError: missing ) after argument list`][missing paren]
  + [`Uncaught TypeError: Assignment to constant variable.`][assignment to constant]
- [MDN — `try...catch`][try...catch]

[x is not defined]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Not_defined
[x is not a function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Not_a_function
[missing paren]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Missing_parenthesis_after_argument_list
[assignment to constant]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Invalid_const_assignment
[try...catch]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/try...catch

<p class='util--hide'>View <a href='https://learn.co/lessons/js-principles-errors-and-stack-traces-readme'>Errors and Stack Traces</a> on Learn.co and start learning to code for free.</p>
