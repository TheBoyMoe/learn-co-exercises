# Javascript Cheatsheet

## Datatypes

seven datatypes - string, number, boolean, symbol, null(has no value), undefined(value not yet assigned), object

use 'typeof' to determine a values data type.

primitives - represent a single value
objects - collection of values

Apart from object, all other datatypes are primitives(quirk of 'typeof' that null reports as an 'object')

Javascript uses coercion when string and number datatypes interact - js will concatenate them together - going from left to right, add the numbers together untill you reach the strin, then concatenate from then on.


## Variables

Naming conventions:
- start with lowercase letter(numbers not valid)
- are case sensitive
- use camelCase(no snake_case or spaces)
- can't use reserved keywords

Initialzing variables:
- require a keyword: 'var', 'let', 'const'
- two step process 
  - declaration(memory is set aside and the variable is assigned the value of 'undefined', has datatype of 'undefined'). NOTE: never assign a variable as 'undefined', when debugging any variable found to be undefined we know has not explicitly been assigned a value;
  - assignment(the actual value is assigned to the variable)

Variables do not have a datatype(unlike java), so we can change the datatype they reference.

With ES2015/ES6 and beyond - use 'let' and 'const' keywords to declare variables. Issues with using 'var':
- varible is global
- doesn't throw an error if you try to declare the same variable more than once

**let**
  - can only be declared once
  - scoped to the function/block declared
  - value can be re-assigned
  - can be declared without a value

**const**
  - can only be declared once
  - scoped to the function/block declared
  - CAN NOT be re-assigned(will always have the same primitive value, or point to the same object - the properties of the object can change)
  - MUST assign a value upon declaration

TIP: always use 'const', unless you need a variable with a primitive value that can change.

## Numbers and Operators

Javascript has only one number type, 'number'. Every number is represented as a float(double-precision floating-point), for anything that requires a high degree of precision, e.g. any calculations using money, an additional library is req'd.

Javascript follows the same rules of **operator priority** as used in maths:
- move from left to right
- parentheses, (), have the highest priority, followed by
- exponentiation, ** (b ** n, base(b) to the power of the exponent(n))
- multiplication, division, remainder, finally,
- addition & subtraction

```javascript
 () --> ** --> *, /, % --> +, - 
```

i++ --> returns the current value before executing the operation 
++i --> executes the operation, then returns the new value

NaN --> Not a Number, js could not return a value for the operation

Javascript provides the Number and Math objects which have a number of useful methods:

- Number.isInteger(val)
- Number.isFinite(val)
- Number.isNaN(val) --> only true for NaN
- Number.parseFloat(val) --> accepts a string
- Number.parseInt(val, base) - accepts a string, base is optional

- Math.PI
- Math.ceil() --> round up
- Math.floor() --> round down
- Math.round() --> rounds up/down, which ever is nearest.
- Math.min()/Math.max() --> returns the lowest/highest of two or more args
- Math.randowm() --> generates a random number between 0 and 1(exclusive)

**Comparison operators**
- always return true/false
- ===, !==, ==, !=, >=, <=, >, <

- == and !=
    - loose equality, performs type conversion
    - you should NEVER use them for comparisons

- === and !==
    - strict equality, does NOT perform type conversion

- >, >, >= and <=
    - perform type conversion
    - only use them when comparing numbers
    - will compare two strings lexicographically, char-by-char left-to-right


## Conditionals and Control Flow

An **expression** is a unit of code that returns a value.
- a primitive value: 7, 'hello'
- arithmetic expressions: 8 * 8
- string operations: 'hello' + ' world'
- comparison operations: 5 > 3
- assignment operations: num = 5
- references to variables: num //=> 5
are all expressions because they resolve to a value;

Variable declarations
- let str
- let string = 'Hello world'
ARE NOT EXPRESSIONS - they do not return a value

**Block Statements**

Javascript statements surrounded by a pair of curly braces, {}.
- return the value of the **last evaluated** expression.
- blocks in javascript have an implicit return( `if...else` and `loop statements` rely on this fact )

```Javascript
{
  'Hello world';
  5 * 5;
  let string = 'abcdef';
  const str = 'ghijklm';
}
//=> returns 25
```
NOTE: in Javascript, you must expplicitly use the `return` keyword to return a value.

**Truthy/falsy values**

In javascript the folowing values are falsy:
- false
- undefined
- null
- 0
- '', "" (empty string)
- NaN

ALL other values are truthy

To check if a value is truthy/falsy
- pass it to the `Boolean` object, e.g. Boolean(0)
- prepend the value with !!, e.g. !!0 //=> false, !!3 //=> true

**Conditional Statements**

Javascript provides 3 structures for implementing condition based control flow:
- `if...else`
- `switch` statement
- ternary operator

```javascript
  if(condition){
    // do something ..
  }
  //=> if the condition evaluates as truthy -> execute the code in the block

  if(!condition){
    // do something....
  }
  //=> if the condition evaluates as falsy -> execute the code in the block
```
With `if..else` and `if...else if...else` conditionals, else acts as a default, ensuring one code block runs if none of the other conditionals evaluate as truthy. Without an `else` block the statement will exit if none of the conditionals evaluate as truthy.

**Switch**

Javascript evaluates the expression, comparing the returned value to each `case` value using `===`
Used when we have an expression that can be handled in many different ways, depending on the value and we don't want an `if...else` block with multiple `else if(value === 'something`)` blocks.

```javascript
  switch(expression){
    case value1:
      // some code
      break;
    case value2:
      // some code
      break;
    default:
      // runs if no matches occur
      break;
```

`break` causes javascript to exit the entire statement. Without the break javascript will execute the next `case's` statements. We can also leave out the `break` when we want to match multiple `case` statements. If `value1` matches, the satements of `case value2` are alo executed, but if only `value2` is a match, only it's statement(s) are executed.Use this trick in situations where if value1 is true, value2 is also true, but not vice versa.


```javascript
  switch(expression){
    case value1:
      // some code
    case value2:
      // some code
      break;
    default:
      // runs if no matches occur
      break;

	let age = 20;
  switch (true) {
    case age >= 21:
      canDrink = true;
    case age >= 18:
      isAdult = true;
      canEnlist = true;
    case age >= 16:
      canVote = true;
  }
```

We can also assign the same statement(s) to mutiple cases:

```javascript
  switch(expression){
    case value1:
    case value2:
    case value3:
      // do something
      break;
    case value4:
      // do something
      break;
    default:
      // do something
      break;
```

The `default` DOES NOT run if the js engine hits a `break` in one of the `case` statements.
REMEMBER: blocks in js return the value of the last expression evaulated. So if you don't execute a break prior to default, any expression it evaluates will be returned.

```javascript
const mood = 'happy';
 
let response;
 
switch (mood) {
  case 'happy':
    response = 'Heck yea; be happy!';
  case 'sad':
    response = "You're awesome; keep your head up!";
  default:
    response = "Sorry, I don't know how to respond to that mood.";
}
//=> const mood = 'happy';
 
let response;
 
switch (mood) {
  case 'happy':
    response = 'Heck yea; be happy!';
  case 'sad':
    response = "You're awesome; keep your head up!";
  default:
    response = "Sorry, I don't know how to respond to that mood.";
}
//=>  "Sorry, I don't know how to respond to that mood." (returned)
//=> response;
//=>  "Sorry, I don't know how to respond to that mood." (returned)
```

You can use the `return` keyword instead of `break` in cases where you need a value returned, e.g. where you use a switch` inside a function`.


**Logical Operators**

`!` -> bang operator, operates on a single expression, returning the inverse of the expression's truthiness.
`!!` -> reports whether a value/expression is truthy/falsy

`&&` -> logical AND, takes two expressions

```javascript
expression1 && expression2
```

If expression1 is `falsy` - returns the value of expression1, the second expression is NOT evaluated
If expression1 is `truthy`- returns the value of expression2

`||` -> logical OR

```javascript
expression1 || expression2
```

if experssion1 is `truthy` - returns the value of expression1, expression2 is not evaluated
if expression1 is `falsy` - returns the value of expression2

`&&` and `||` are also used in conditional statements:

```javascript
if(expression1 && expression2){
  // do something
}
//=> the code block is evaluated if both expressions1 and 2 evaluate as true

if(expression1 || expression2){
  // do something
}
//=> the code block is evaluated if either expression evaluates as true


## Functions

In javascript functions are:
- declared using the `function` keyword
- start with a lowercase letter and use camelCase
- have a parantheses, (), following the function name which may or may not have a comma separated list of parameters. These are the placeholders for arguments passed into the fulction when it is invoked.
- a pair of curly braces denote the function body, contain the statements that are executed when the function is invoked.
- inside the function body the passed-in args become local variables, accessible only inside the function body.
- they are assigned in the order in which they are passed to the function when it is invoked.
- if fewer args are passed in than the number declared, the remaining variables are initialized with a value of `undefined`.
- if you pass in more args that those defined, the additional args are ignored
- all functions in javascript return a value. You MUST use the `return` keyword to return a value, otherwise the function simply returns undefined. As soon as the js engine reaches a `return` statement that value is returned and the function exited, any following lines are not executed.
- you MUST add a pair of parantheses after the function name to invoke it.

