# JavaScript Reduce Lab

## Overview
This lab will give you practice using a reduce function and iterating over different abstractions. 

## Introduction
By now, we know that `.reduce()` is nothing more than a function to reduce an array to another value, such as a number, a string, or another array. This allows us to easily count word occurrences, calculate a total sum of product prices, and so on.

In this lab, we'll focus on flexing those `reduce()` muscles! Remember — `Array.prototype.reduce()` takes two arguments: the `callback` and the `initialValue`.

## Technologic
Pat and Dave are hard at work in the battery factory. They've assembled several batches of batteries today. Let's count how many assembled batteries we ended up with while they go out for an oil change.

* Create a new variable called `totalBatteries`, which is the sum of all of the battery counts in the `batteryBatches` array. Naturally, use `.reduce()` for this!

## Perfecting the monologue
![Walter White](https://media.giphy.com/media/YyOQPNOesPtWo/giphy.gif)

One of the most iconic scenes in the television show  "Breaking Bad" is where Walter White reveals to his wife, Skyler, how deeply entrenched he is in the meth business. Writing this monologue must have been a pain. For future episodes, it would be great if the show's writer could get an overview of the number of sentences mapped by word count.

For example, say we have these three lines:
```js
const lines = [
  'Who are you talking to right now?',
  'Who is it you think you see?',
  'Do you know how much I make a year?',
];
```

Our output would look like this:
```
{ '7': 2, '9': 1 }
```

This output can be interpreted as: _'We have two sentences with 7 words, and one sentence with 9 words'_. That should help the writer to write even more dramatic monologues!

* Create a new variable called `wordCountMap` that reduces the `monologueLines` to a map that resembles the output as shown above.

## Resources

* [MDN: Array.prototype.reduce()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-reduce-lab'>Reduce Lab</a> on Learn.co and start learning to code for free.</p>
