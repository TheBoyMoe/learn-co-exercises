Functions Returning Functions Lab
---

## Objectives

1. Practice writing functions that return other functions
2. Practice passing a function to another function
3. Practice calling a function returned by another function

## Introduction
Functions are a very important part of JavaScript, and you will use them pretty much all of the time. Without functions,
we wouldn't get anything done! There is a lot more to functions than meets the eye, which we will discover together
throughout this unit. In this lab, we'll take a look at how we can use first-class functions to pass around functions,
or return them.

## Exercise 1 — The final countdown
![Europe](http://www.ifsociety.com/img_upload/artists/1050a.jpg)

*Dudududuuuuuu. Dudududu.*

The band, Europe, has been struggling to keep in rhythm with each other. When the keyboard tunes stop, the vocals should
kick in after two seconds — for dramatic effect, naturally! Unfortunately, the lead singer has been missing the mark
lately. Let's help him out!

We'll start things off by creating a `countdown()` function. This function takes one argument, `callback`, which is a
function. Using `window.setTimeout()`, we will wait two seconds before calling the `callback` function that was
passed into the `countdown()` function. This exercise demonstrates the use of callbacks for async operations. If we
didn't use a callback, our program would continue right away instead of waiting for the callback to be called.


## Exercise 2 — Playing Scrabble
![Scrabble](http://www.bolsboardgames.com/scrabble.jpg)

Let's say we're trying to recreate Scrabble in JavaScript. Some board tiles can give us double or triple letter score.
Let's create a helper function that takes a number (let's call it the `multiplierValue`). This function then **returns a
function** that multiplies a given value by the `multiplierValue`. In your code, do the following:

1. Create a `createMultiplier()` function. Make sure it returns the right thing!
2. Create a `doubler` variable that uses the `createMultiplier()` function to create a function that doubles any given number.
2. Create a `tripler` variable that does the same thing as the `doubler`, but it triples the value instead.

## Exercise 3 — It's part(y)(ial) time
Instead of a function returning another function (like we did in the previous exercise), we can also write a function
that takes two values right away: the `multiplierValue` and the `value`. However, we can't create the `doubler` and
`tripler` functions by just calling this new function with two arguments! The trick is to _partially apply_ the function.
We can do this using [`.bind()`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_objects/Function/bind).
Quick hint: you can forget about `.bind()`'s first argument (the `this` context) for now — you can use `null` as its value.

To pass all tests, do the following:

1. Create a `multiplier()` function that takes two arguments and multiplies them together.
2. Create a `doublerWithBind` variable that partially applies the `multiplier()` function by passing in `2` as its first
argument.
3. Create a `triplerWithBind` variable that partially applies the `multiplier()` function by passing in `3` as its first
argument.

## Resources

- [Wikipedia: First-class function](https://en.wikipedia.org/wiki/First-class_function)
- [MDN: Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions)
- [JavaScript is Sexy: Higher-Order Functions](http://javascriptissexy.com/tag/higher-order-functions/)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-first-class-functions-lab'>First Class Functions Lab</a> on Learn.co and start learning to code for free.</p>
