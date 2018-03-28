JavaScript Inheritance Patterns Lab
---

## Objectives

1. Practice writing JavaScript objects that inherit from other objects
2. Practice using `Object.create()`
3. Practice use `hasOwnProperty()`
4. Explain what a prototype is in JavaScript

## Introduction

In this lab we're going to create a geometry application that allows us
to place various shapes on a plane and move them about. We'll be using
prototypal inheritance with `Object.create` to build objects that inherit from and extend
base objects. For a refresher on using prototypal inheritance with
`Object.create`, check the [MDN example](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create).

We'll also be exploring the idea of *composition*, or using objects as
parts with which we'll compose other objects. If inheritance describes
an *is-a* relationship, then you can think of composition as describing
a *has-a* relationship.

For instance, if a `Car` has a property `engine` property, and that
property holds an `Engine` object with its own properties and methods,
that's composition. An `Engine` would never inherit from `Car`, and a
`Car` would never inherit from `Engine`, but we can use an `Engine` (and
other objects) to compose a `Car`.

Remember that a prototype is essentially just an object, and any
properties and methods we add to an object's prototype will be available
to all objects that inherit from that prototype via delegation. If a
property or method isn't found on an object, then JavaScript will look
at every object up the prototype chain until it is found (or not).

Follow the instructions below, and don't forget to make sure your tests
pass!

## Instructions

1. Define a `Point` object that is constructed with an `x,y` coordinate
   pair to indicate its position. Add a `toString` function to the Point
prototype to return the location in `(x, y)` format.
2. Define a `Shape` object. This will be the base for all shapes on the
   plane. It should have an `addToPlane` function that takes two
integers, `x` and `y`, as arguments. This function should assign a `Point`
to the Shape's `position` property based on these arguments. Shape
should also define a `move` function that takes an `x,y` pair of
arguments and moves the `position` to a new `Point`.
3. Define a `Circle` object that inherits from `Shape` and is
   constructed with an integer argument that sets the `radius` property.
Define and implement functions on `Circle` to calculate `area()` and
`circumference()` based on the `radius`.
4. Define a `Polygon` object that inherits from `Shape`. It should be
   constructed with an array of `Side` objects that have a `length`
property. `Polygon` should have a property called `sides` that holds the
array of `Side` objects. Implement a function called `perimeter()` that
calculates the perimeter of any `Polygon` based on the lengths of the
`sides`. Implement a function called `numberOfSides()` that returns the
number of sides.
5. Define a `Quadrilateral` object that inherits from `Polygon` and is
   constructed with four integer arguments representing the side
lengths.
6. Define a `Triangle` object that inherits from `Polygon` and is
   constructed with three integer arguments representing the side
lengths.
7. Define a `Rectangle` object that inherits from `Quadrilateral` and is
   constructed with two integer arguments that set `width` and `height`
properties. Implement an `area()` function to calculate the area.
8. Define a `Square` object that inherits from `Rectangle` and is
   constructed with a single integer argument that sets a `length`
property. If everything is wired up right in the prototype chain, `Square` should have access to `area()`, `perimeter()`, `numberOfSides()`, `addToPlane()`, `position`, `move()`, `width`, `height` and so on.
9. Define and implement a function for `Square` called
   `listProperties()` that returns a string containing only the
properties that belong to `Square`. It should not list the
`constructor`, `area`, `perimeter`, and other things inherited from the
prototype chain.

## Resources

- [MDN: Object.create()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create)
- [MDN: hasOwnProperty()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty)

<p class='util--hide'>View <a href='https://learn.co/lessons/javascript-inheritance-patterns-lab'>Inheritance Patterns Lab</a> on Learn.co and start learning to code for free.</p>
