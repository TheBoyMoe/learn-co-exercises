Prototypal Inheritance in Javascript
---

## Objectives

1. Explain how prototypal inheritance works in JavaScript
2. Practice inheriting from prototypes with `Object.create()`
3. Explain how to use `hasOwnProperty()`

## Introduction

There are two primary types of object-oriented (OO) languages: class-based
and prototype-based.

In a class-based OO language, such as Ruby, Java, C#, and C++, we must
first design the *Class*, or blueprint, of an object, and then create
objects from that blueprint in order to use them.

JavaScript uses prototypal OO. Instead of creating a nonfunctional class
definition, we actually create the object, which is then used as a
prototype to create other objects.

So in both OO paradigms, we're defining the object, but in JavaScript,
that definition is a functioning prototype that we can use to build
other objects.

## Inheritance

Where this distinction between class-based and prototype-based OO really
comes to the forefront is in *inheritance*.

Inheritance is a part of object-oriented programming that concerns
itself with code reuse. Inheritance allows us to build more complex or
specific object types out of more simple, previously defined object
types.

### "is-a"

As a real-world example, consider a rectangle. A rectangle has some
rules to it, or *properties*. A rectangle has four sides. Opposite sides
are equal length and parallel. Adjacent sides are perpendicular.

Now consider the square. A square shares all of the properties of a
rectangle, and by definition *is* a rectangle. However, the square has
an additional important property that a rectangle does not: a square is
equilateral. All four sides are the same length.

So a square *is a* rectangle, but a rectangle *is not a* square. In
object-oriented programming, we would consider this *is-a* relationship
a place to use inheritance. That is, we could define a rectangle, then
create a square out of that rectangle and add the additional properties.
The inheritance allows us to reuse the rectangle's properties without
having to redefine them on the square.

Let's see this in action, first without inheritance:

```js
// Rectangle constructor
function Rectangle(sides, width, height) {
  this.sides = sides;
  this.width = width;
  this.height = height;
  this.area = function() {
    return this.width * this.height;
  }
  this.perimeter = function() {
    return (this.width + this.height) * 2;
  }
}

// Square constructor
function Square(sides, length) {
  this.sides = sides;
  this.width = length;
  this.height = length;
  this.area = function() {
    return this.width * this.height;
  },
  this.perimeter = function() {
    return (this.width + this.height) * 2;
  }
}

var rect = new Rectangle(4, 3, 5);
var square = new Square(4, 2);

rect.area();
square.area();
```

This works great, but we've created two objects that have basically the same properties and behaviors.
The only difference is that `width` and `height` are the same in a
`square`, so we only take one `length` argument and use it to set
`width` and `height` to the same thing.

Inheritance allows us to create a square from a rectangle and then alter
the square as necessary to make a new type of object, without having to
repeat everything we did when constructing the rectangle. So how can we
implement this using inheritance in JavaScript?

### Constructor-Based Inheritance

It isn't much of a stretch to see a simple way to make `Square`
"inherit" from `Rectangle` by just using the constructor and a `call` to
set `this` to a new square:

```js
// Rectangle constructor
function Rectangle(sides, width, height) {
  this.sides = sides;
  this.width = width;
  this.height = height;
  this.area = function() {
    return this.width * this.height;
  }
  this.perimeter = function() {
    return (this.width + this.height) * 2;
  }
}

// Square constructor
function Square(sides, length) {
  Rectangle.call(this, sides, length, length);
}

var rect = new Rectangle(4, 3, 5);
var square = new Square(4, 2);

rect.area();
square.area();
```

This will work, and it certainly reduces the repeated code. But under
the hood, there's a problem. Our `square` isn't truly inheriting from
the prototypical `Rectangle`. It is, in essence, a standalone object
that only copied what `Rectangle` had available at the time of
instantiation.

To illustrate, try adding this code:

```js
Rectangle.prototype.internalAngles = 90;
rect.internalAngles;
square.internalAngles;
```

Here, we've added a new property, `internalAngles`, to
`Rectangle.prototype`. This means that everything created from the
prototypal `Rectangle` will also have access to this new property, even
though it was added after the fact. This is done through *delegation*,
which we'll explore in the next section.

So `rect` can access `internalAngles`, but `square` cannot. Why? Because
`square` wasn't created with the `Rectangle.prototype`.

Why does that matter? What exactly *is* a prototype, and why is it important?

### Prototypes

Every object in JavaScript has a `prototype`. This `prototype`
is essentially the "parent" object that the object was created from, and
it provides any number of methods and properties to that object.

Any object created with the object literal `{}` will inherit from the
`Object.prototype`, meaning it will get certain methods and properties
for free. Try it yourself:

```js
var o = {};
console.log(o.toString());
```

We didn't define a `toString()` function on `o` -- it came from
`Object.prototype`.

So the prototype is the parent object that this one was created from,
and when we try to access a property or method on our object that isn't
defined by our object, JavaScript will check our object's prototype, and
if it's not there, then *that* object's prototype, and so on, until it
finds what it's looking for or reaches the end of the prototype chain at
`Object.prototype`. This is a form of delegation - rather than force
every object to handle everything it inherits on its own, it can
delegate up the prototype chain.

This means that every object that inherits from another gains two
benefits from prototypal inheritance.

The first is efficiency. Not having to copy every method to
every inherited object keeps things light and simple.

The second is that this delegation allows already-instantiated objects
to reap the benefits of changes to their prototype at runtime.

Let's revisit the example above:

```js
// Rectangle constructor
function Rectangle(sides, width, height) {
  this.sides = sides;
  this.width = width;
  this.height = height;
  this.area = function() {
    return this.width * this.height;
  }
  this.perimeter = function() {
    return (this.width + this.height) * 2;
  }
}

// Square constructor
function Square(sides, length) {
  Rectangle.call(this, sides, length, length);
}

var rect = new Rectangle(4, 3, 5);
var square = new Square(4, 2);

rect.area();
square.area();

Rectangle.prototype.internalAngles = 90;
rect.internalAngles;
square.internalAngles;
```

If we just examined these two objects with `console.log(square)` and
`console.log(rect)`, we would see that neither explicitly has the
`internalAngles` property. This means that `rect` is *delegating* it to
the `Rectangle` prototype, and `square` is not.

They were both created from the `Rectangle` constructor though. What
gives?

### Constructors Aren't Enough

Using constructor functions with the `new` keyword is a handy way to
create objects, but it can cause problems by obscuring, and sometimes interfering with, the benefits of
using JavaScript in a purely prototypal way. This is most obvious when we try to inherit from another object and take advantage of the delegation features in the prototype system.

When an object is created, its prototype is set to the
object it was created from. In the case of a new object created with the
`{}` literal, that prototype will be `Object.prototype`.

But what do we know about functions in JavaScript? They are also
objects! So when we create an object from a constructor function, we are
really making that function the object's `prototype`!


Let's look at our example one more time.

```js
// Rectangle constructor
function Rectangle(sides, width, height) {
  this.sides = sides;
  this.width = width;
  this.height = height;
  this.area = function() {
    return this.width * this.height;
  }
  this.perimeter = function() {
    return (this.width + this.height) * 2;
  }
}

// Square constructor
function Square(sides, length) {
  Rectangle.call(this, sides, length, length);
}

// rect prototype becomes Rectangle()
var rect = new Rectangle(4, 3, 5);
// square prototype becomes Square()
var square = new Square(4, 2);

// this works because the rect prototype is still Rectangle
Rectangle.prototype.internalAngles = 90;
rect.internalAngles;

// but the square prototype is not Rectangle
square.internalAngles;
```

Even though we call the `Rectangle` constructor function inside the
`Square` constructor function, the function call that actually *creates*
`square` is `new Square()`, so the prototype for the square is
`Square.prototype`, meaning that we haven't inherited from
`Rectangle` at all. All we've done is *borrowed* its constructor function to make our own
object, and made copies of its properties and methods, but haven't taken
advantage of prototyping.

### Assigning Prototypes With Object.create()

In order to create a `Square` that truly inherits from `Rectangle` and takes advantage of JavaScript's prototype system, we'll need to make a few changes to how we put our objects together.

A common pattern for defining objects is to combine the use of a
constructor function for simple initialization values, and to directly
add functions to the object's `prototype`, like this:

```js
function Rectangle(sides, width, height) {
  this.sides = sides;
  this.width = width;
  this.height = height;
}
Rectangle.prototype.area = function() {
  return this.width * this.height;
}
Rectangle.prototype.perimeter = function () {
  return (this.width + this.height) * 2;
}
```

Now, when we want to instantiate a rectangle object, we can do the following:

```js
var rect = new Rectangle(4, 3, 2);
```

And everything works as expected. But what if we are creating a system
that represents a cartesian plane, and every shape on the plane needs an
(x,y) coordinate position?

We could add those values to our `Rectangle` definition, but we also
know we'll be creating other shapes on the plane as well, like triangles and trapezoids and dodecahedrons, oh my!

Since a rectangle *is-a* shape, a triangle *is-a* shape, and a trapezoid
*is-a* shape, it stands to reason that we should be inheriting from a
`Shape` base object. Shapes also have a number of sides, so there's no
need for `Rectangle` to be in charge of that.

```js
function Shape(sides, x, y) {
  this.sides = sides;
  this.x = x;
  this.y = y;
}
```

Now we can let our `Rectangle` inherit from `Shape` by using
`Object.create` with the `Shape` prototype:

```js
function Rectangle(x, y, width, height) {
  //call superclass constructor
  Shape.call(this, 4, x, y);
  //set rectangle values
  this.width = width;
  this.height = height;
}
// set Rectangle prototype to an instance of a Shape
Rectangle.prototype = Object.create(Shape.prototype);
// set Rectangle constructor
Rectangle.prototype.constructor = Rectangle

// extend with Rectangle behavior
Rectangle.prototype.area = function() {
  return this.width * this.height;
}
Rectangle.prototype.perimeter = function () {
  return (this.width + this.height) * 2;
}
```

What we've done here is defined our `Rectangle` constructor to use our
`Shape` constructor, similar to how we did it earlier with `Square`,
then added the `Rectangle` specific properties.

The key difference is that we are explicitly setting the
`Rectangle.prototype` to a `Shape.prototype` using
`Object.create`. This allows us to assign a prototype to an object when we
create it, rather than letting it be assigned for us via the
constructor function.

We also need to set `Rectangle.prototype.constructor` to the proper
function, so that it knows to create a `Rectangle` and not a `Shape`.

Finally, we want to *extend* `Rectangle` to add behavior that isn't a
part of `Shape`. We do that the same way as before, adding new functions
directly to `Rectangle.prototype`, however, we do it after everything
else. Setting `Rectangle.prototype = Object.create(Shape.prototype)`
overwrites the default `Rectangle` prototype, so we have to do that
first, and then extend our subclass afterward, or else we'll overwrite
our extended behavior.

Let's create a new `Rectangle` object and examine some things.

```js
var rect = new Rectangle(1,0,5,3)
var shape = new Shape(3,2,2)

console.log(rect.sides);
// 4
console.log(shape.sides);
// 3

console.log(rect.width);
// 5
console.log(shape.width);
// undefined

console.log(rect.area());
// 15
console.log(shape.area());
// TypeError - no function

console.log(rect instanceof Shape);
//true
console.log(shape instanceof Rectangle);
//false
```

Let's examine each of these statements and what's happening.

First we create a new `Rectangle` and `Shape` objects with their
respective constructors.

If we try to access `rect.sides`, we get `4`. We know that `sides` is
defined by `Shape`, so it looks like our constructor worked so far and
our `Rectangle` inherited the properties of `Shape`.

When we try to call `width` on both objects, `rect` gives us `5`, but
`shape` doesn't have access to `width`. This makes sense, because
`Shape` doesn't have `width`, but `Rectangle` does. This is one of our
extended properties.

Similarly, we see that `rect` has `area` and `shape` does not, which
also makes sense, because `area` is one of the functions we added to the
`Rectangle` prototype after inheriting from `Shape`.

Finally, we can prove that `rectangle` is constructed from `Shape` by
checking if `rect instanceof Shape` returns true. The opposite case is
false, because `shape` was not constructed from `Rectangle`.

If we extend the behavior of the `Shape` prototype, what happens? Let's
add a `move` function and a `position` function.

```js
Shape.prototype.move = function(x,y) {
  this.x = x;
  this.y = y;
}

Shape.prototype.position = function() {
  return(this.x + ", " + this.y);
}
```

Now, without doing anything, we can use both these functions on our
existing `rect` and `shape` instances.

```js
rect.move(8,9);
rect.position();
// 8, 9

shape.move(2,3);
shape.position();
// 2, 3
```

This is the magic of delegation when we inherit with prototypes!

#### hasOwnProperty()

To see this prototypal delegation in action, let's look at the
properties of our `rect` instance. We can iterate over them like this:

```js
for (var prop in rect) {
  console.log("rect." + prop + " = " + rect[prop]);
}
```

This gives us a lot of information and looks a little like this:

```js
rect.sides = 4
rect.x = 4
rect.y = 3
rect.width = 5
rect.height = 3
rect.constructor = function Rectangle(x, y, width, height) {
  //call superclass constructor
  Shape.call(this, 4, x, y);
  //set rectangle values
  this.width = width;
  this.height = height;
}
rect.area = function () {
  return this.width * this.height;
}
rect.perimeter = function () {
  return (this.width + this.height) * 2;
}
rect.move = function (x,y) {
  this.x = x;
  this.y = y;
  }
rect.position = function () {
  return(this.x + ", " + this.y);
}
```

But we know that we didn't define `position` and `move` on `Rectangle`.
And `area` and `perimeter` are actually defined on the `Rectangle`
prototype. And what is that `constructor` doing in there?

If we iterate over all the properties of `rect` in this way, it includes
everything directly available on `rect`, as well as everything that can
be found all the way up the prototype chain.

We can use `hasOwnProperty()` to filter this output to only the
properties directly available on `rect`, like this:

```js
for (var prop in rect) {
  if(rect.hasOwnProperty(prop)) {
    console.log("rect." + prop + " = " + rect[prop]);
  }
}
```

This way, we can tell if a property was directly set on our instance, or
if we're inheriting it from somewhere else.

### Extending the Inheritance Chain

A rectangle is really just a special quadrilateral, right? Let's build out this example a little more and see some inheritance in action.

```js
function Shape(sides, x, y) {
  this.sides = sides;
  this.x = x;
  this.y = y;
}

function Quadrilateral(x, y, sideOneLength, sideTwoLength, sideThreeLength, sideFourLength) {
  // call Shape constructor
  Shape.call(this, 4, x, y);
  this.sideOneLength = sideOneLength;
  this.sideTwoLength = sideTwoLength;
  this.sideThreeLength = sideThreeLength;
  this.sideFourLength = sideFourLength;
}

//inherit from Shape prototype
Quadrilateral.prototype = Object.create(Shape.prototype);
Quadrilateral.prototype.constructor = Quadrilateral;

//extend Quadrilateral
Quadrilateral.prototype.perimeter = function() {
  return this.sideOneLength + this.sideTwoLength + this.sideThreeLength + this.sideFourLength;
}

function Rectangle(x, y, width, height) {
  //call Quadrilateral constructor
  Quadrilateral.call(this, x, y, width, height, width, height);
  //set rectangle values
  this.width = width;
  this.height = height;
}
// set Rectangle prototype to an instance of a Shape
Rectangle.prototype = Object.create(Quadrilateral.prototype);
// set Rectangle constructor
Rectangle.prototype.constructor = Rectangle

// extend with Rectangle behavior
Rectangle.prototype.area = function() {
  return this.width * this.height;
}

function Square(x, y, length) {
  //call Rectangle constructor
  Rectangle.call(this, x, y, length, length)
  this.length = length;
}

Square.prototype = Object.create(Rectangle.prototype);
Square.prototype.constructor = Square

var square = new Square(1,1,3);
square.length;
// 3 - defined on Square

square.width;
// 3 - inherited from Rectangle

square.sideOneLength;
// 3 - inherited from Quadrilateral through Rectangle

square.position();
// 1,1 - from Shape

square.move(2,3); // from Shape
square.position();
// 2,3

square.area();
// 9 - from Rectangle
square.perimeter();
// 12 - from Quadrilateral
```

Now we have a base `quadrilateral` that we can use to build a
`rectangle`. We'll extend the rectangle to have properties to determine
more rectangular-specific things, like `width`, `height`, and `area`. It
wouldn't make sense to define `area()` at the `quadrilateral` level,
because it's a different formula depending on the shape. So we do that
on `rectangle`. But we preserve `perimeter()` by using the side length
properties of `quadrilateral`, so that even when we get down to
`square`, we can still use the prototype system to delegate our
perimeter formula up to `quadrilateral`.

Since a square is just an equilateral rectangle, our `square` can use
everything from the `rectangle` prototype, and just extend it to
specifically set one side-length value instead of a `width` and
`height`.

We could extend this further, inserting a `Polygon` into the chain
between `Shape` and `Quadrilateral`, and creating a `Triangle` that
inherits from `Polygon`, and subclasses for `RightTriangle` and
`EquilateralTriangle` and `IsocelesTriangle`, all of which define their
own rules for side lengths and internal angles.

This is the basic pattern of an inheritance chain. A parent object is
more general than a child, which takes attributes from the parent and
adds more specific attributes of its own.

## Summary

We've talked about the difference between class-based and prototypal
inheritance models in object-oriented languages, and learned that every
object in JavaScript can serve as a prototype with which we can build
other objects.

We've seen how to emulate class-like inheritance with constructor
functions and the `new` keyword, and explored potential problems with
that approach.

We've seen how to create prototype objects and then inherit from them
with `Object.create()`, avoiding the pitfalls of `new`, and learned how
to use `hasOwnProperty()` to determine if a given property belongs to an
object or is delegated to its prototype.

## Resources

- [Object.create()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create)
- [for...in](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in)
- [hasOwnProperty()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty)
