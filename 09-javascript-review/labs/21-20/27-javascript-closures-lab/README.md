JavaScript Closures Lab
---

## Objectives

1. Use closures in an application setting
2. Return functions that close over "private" variables
3. Use a closure to define a partially applied function

## Introduction
Now that we've talked about what closures are and how we can leverage them to write better code, it's time to put that knowledge to the test! As a quick reminder, a closure is a function that has access to the variables (i.e. parameters and regular variables) and methods declared in the parent scope, even after the parent function has been executed. We can use closures to emulate 'private' variables and methods, as well as use them to make creating certain functions quicker and more dynamic.

## Three-point turn
![Austin Powers car](https://media.giphy.com/media/y6Sl42U3xEFkk/giphy.gif)

Sometimes, in applications, we need to count things. Austin Powers isn't a great driver — see above for the damning
evidence. Luckily, his poor driving skills give us ample opportunity to stretch our coding muscles. Let's create
closures that we can use to keep track of how many times he's bumped into the wall.

* Create a function, `bumpCounter()`, that has a variable called `counter`. This variable should *not* be accessible
outside of the function!
* The `bumpCounter()` function has two inner functions: `addBump()` and `getBumps()`. These two functions need to be returned since they will be used to increase the counter and get the counter value.
* The `addBump()` function should increase the counter by 1.
* The `getBumps()` function should return the current count.


## Blood in the water
![Sharks with frickin' laser beams](https://media.giphy.com/media/EW4ObFkJPMJQA/giphy.gif)

Dr. Evil has a penchant for murderous animals. As if sharks weren't deadly enough, now he wants to attach **laser beams**
to their heads! Being his ever faithful servant, let's use a closure to attach various deadly devices to his sharks.

* Create a function, `createAnimal()`, that takes one parameter, `animalType`.
* Create an inner function in this `createAnimal()` function that also has one parameter, `deadlyDevice`. This function
then returns an object that forms our diabolical creation. This object has two properties, `animalType` and `deadlyDevice`
that are the given arguments to both functions.
* An example of the output: `{ animalType: 'Monkey', deadlyDevice: 'Lightsaber' }`
* Create a shark creator function by calling `createAnimal()` with the `'Shark'` string. This should be assigned to a
variable called `sharkCreator`.
* Add a variable called `sharkWithFrickinLaserbeam` that is a combination of a `'Shark'` and `'Laserbeam'`.
* Add a variable called `sharkWithFrickinCannon` that is a combination of a `'Shark'` and `'Cannon'`.

Thanks to our ingenious engineering, we can create an infinite amount of sharks with various deadly contraptions
attached. Because we're using a closure that we partially apply, we can also do this for other animal species. Dr. Evil
will surely be pleased!

## Resources

- [Curried JavaScript functions](http://javascript.crockford.com/www_svendtofte_com/code/curried_javascript/)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-closures-lab'>Closures Lab</a> on Learn.co and start learning to code for free.</p>
