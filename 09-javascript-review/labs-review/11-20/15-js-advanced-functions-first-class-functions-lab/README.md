# First-Class Functions Lab

## Objectives
1. Invoke functions assigned to a variable.
2. Invoke functions stored in a data structure.
3. Write functions that return other functions.
4. Pass a function to another function.
5. Call a function returned by another function.

## Introduction
Functions are a very important part of JavaScript, and you will use them all the time. Without functions, we wouldn't get anything done! In this lab, we'll take a look at how we can use functions as first-class objects to pass them around, store them in variables and data structures, and return them from other functions.

+ `returnFirstTwoDrivers()` — Declare a variable with `const` that is assigned an anonymous function. The assigned function should accept an array of drivers as an argument and return the **first** two drivers in the array.
+ `returnLastTwoDrivers()` — Declare a variable with `const` that is assigned an anonymous function. The assigned function should accept an array of drivers as an argument and return the **last** two drivers in the array.
+ `selectingDrivers` — This is an array containing two elements: the two functions that we previously defined (`returnFirstTwoDrivers()` and `returnLastTwoDrivers()`).
+ `createFareMultiplier()` — This is a higher-order function that takes in one argument, an integer, and returns a function that will multiply a fare for a ride accordingly. If `createFareMultiplier()` receives an argument of `4`, it will return a function that takes in a fare as an argument and quadruples the fare.
+ `fareDoubler()` — Declare a variable with `const` and assign a function returned by `createFareMultiplier()` to it. Invoke `createFareMultiplier()` in such a way that the new `fareDoubler()` function accepts a fare as its lone argument and doubles it.
+ `fareTripler()` — Declare a variable with `const` and assign a function returned by `createFareMultiplier()` to it. Invoke `createFareMultiplier()` in such a way that the new `fareTripler()` function accepts a fare as its lone argument and triples it.
+ `selectDifferentDrivers()` — This function takes two arguments, an array of `drivers` and either the `returnFirstTwoDrivers()` or `returnLastTwoDrivers()` function. Based on these two arguments, `selectDifferentDrivers()` will return either the first two drivers or the last two drivers.

## Resources
- [Wikipedia: First-class function](https://en.wikipedia.org/wiki/First-class_function)
- [MDN: Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions)
- [JavaScript is Sexy: Higher-Order Functions](http://javascriptissexy.com/tag/higher-order-functions/)

<p class='util--hide'>View <a href='https://learn.co/lessons/js-advanced-functions-first-class-functions-lab'>First-Class Functions Lab</a> on Learn.co and start learning to code for free.</p>
