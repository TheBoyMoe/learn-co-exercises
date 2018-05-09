# Class Syntax in JS Lab

## Objectives
+ Refactor code to use class syntax
+ Practice inheritance using the extends keyword

## Instructions
With our new knowledge of prototypes, we would like to refactor our previously written code to declare each function only one time.

In `index.js`, build an ES2015 `BoardMember` class with the following properties set by the constructor: `name`, `homeState`, and `training`.

Add following methods to the prototype using the class syntax:
+ `veto` — returns `No, I must disagree`

+ `approve` — returns `You can do that!`

+ `doCharity` — returns `I like to help people.`

+ `releasePressStatement` — returns `You will see great things from Scuber.`

+ `sayHi` — returns `"Hi, my name is <name>. I am from <homestate>, and I was trained in <training>.`


In `index.js`, build an ES2015 `Ceo` class with the following properties: `name`, `training`, and `homeState`.  Use inheritance to accomplish this.  A `Ceo` should have all of the methods that a `boardMember` has.

Add a new method giving the `Ceo` the ability to hire new employees.  This functionality should not be available to a board member.  So the `Ceo` would have one new method:
+ `hireEmployee` — returns `Welcome aboard!`

<p class='util--hide'>View <a href='https://learn.co/lessons/js-object-oriented-class-syntax-lab' title='Class Syntax in JS Lab '>Class Syntax in JS Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/js-object-oriented-class-syntax-lab'>Class Syntax Lab</a> on Learn.co and start learning to code for free.</p>
