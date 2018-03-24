## JavaScript Map Lab


## Overview 

The `.map()` function allows us to transform elements in an array from one value to another, we can take a look at some practical examples. There's no need to implement your own `map()` function, since we can readily use the `Array.prototype.map()` method.

## Uncovering alliances
![Decepticons](https://media0.giphy.com/media/GsrGBNNkXAfoA/200.gif)

Imagine we're a top-end cyber researcher for DARPA. The military has given us a list of robots. We also have a manifest of all known Decepticon robot names. Our job is to go through the list of robots, and set their alliance accordingly.

* Create a new variable called `sortedRobots`;
* The value of this variable is the mapped `robots` array;
* Return each robot object with the `alliance` filled in with either an `'autobot'` or `'decepticon'` string.
* To figure out a robot's alliance, check if their name exists in the `knownDecepticons` array.
* (Hint: use `Array.prototype.includes` to easily check if an element exists in an array.)
* The original objects in the `robots` array must **not** be modified, so be sure to use `Object.assign()`

## The White Stripes
![The coolest zebra.](https://media.giphy.com/media/bHoFqabfGJLpu/giphy.gif)

A zebra without stripes is just a silly looking horse. We have a `zebraStripes` array that represents the stripes of our dancing friend up here, but the stripes don't have any color yet. Let's fix that!

* Create a new variable called `coloredZebraStripes`;
* The value of this variable is the mapped `zebraStripes` array;
* Return each stripe object with the `stripe` filled in with either a `'black'` or `'white'` string.
* A stripe is black when the stripe's index is even, and it's white if a stripe's index is odd.
* (Hint: the callback we pass to `.map()` takes more than one parameter)
* The original objects in the `zebraStripes` array must **not** be modified, so be sure to use `Object.assign()`

## Resources

* [MDN: Array.prototype.map()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-map-lab'>Map Lab</a> on Learn.co and start learning to code for free.</p>
