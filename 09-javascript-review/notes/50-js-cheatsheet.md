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

NOTE: Javascipt has a notion of `pure` and `impure` functions
- a PURE functions behaviour is prediictable. 
- If a pure function is repeatedly invoked with the same set of arguments, the function will always return the same result.
- Also, invoking the function has no (external) side-effects e.g. making a network or database call or altering any object(s) passed to it as an argument.
- IMPURE functions are the opposite: the return value is not predictable, and invoking the function may have side-effects.


**Scope & Execution Context** 

Scope refers to where variables and functions are accessible/visible within out code. In javascript we also have an `Execution Context`, which creates a new scope. An `execution context` encompasses all of the variables and functions declared inmthat context. It means that any expression we write can access any variable or invoke any function in that context.

`Global Scope/Execution Context` implicitly wraps all of the javascript code in a project. Any variable/function written in the `global scope` are accessible everywhere within your javascript code. A variable/function not declared inside a function or block is in the `global scope/execution context`. Any variable or function exression referenced with the `var` keyword is in the global context.

NOTE: 
- variables/functions expresions declared with `let` and `const` are NOT added to the global context - they will be accessible in the context in which thay're defined.
- to add a variable/expression function to the global acop/context either declare it without a keyword or use `var` if out side of a function.


`Function Scope` - execution context/scope that is created within the function's body - between the curly, {}, braces.
- we can access any varibles/functions declared within the function's scope
- we can access variables/functions declared in ANY OUTER contexts's (that are in the same context 'chain')
- we CAN NOT access any variables/functions declared with 'var', 'let', or'const' within a function from outside of the function. Variables and function expressions declared without a keyword are visible/accessible.

`Block Scope` - introduced by ES6/2015, applies only to variables and function expressions declared using the `let` and `const` keywords and gives these expressions block level scope( block simply refers to any code written within a pir of curly braces, e.g. loop), i.e. they are not accessible OUTSIDE the block but are accessible inside the block or to any inner blocks, whether other blocks or functions.
- this does not apply to `var` - it DOES NOT have block level scope.

REMEMBER: variables/function expressions declared WITHOUT `var`, `let` or `const` are ALWAYS GLOBALLY SCOPED regardless of where they are written in your code.


**Scope Chain**

Every function has access to a scope chain. This includes the function's oute scope (the scope in which it was declared), the outer scope's outer scope and so on up to the global context. This scope chain makes variables and functions declared in these outer scopes accessible within the inner/nested function. This chain DOES NOT go in the opposite direction, i.e inner scopes within the function are NOT accessible to it.

A function declared in a js file NOT not declared in any other funciton is in the global scope. It has access to variables declared in the function body, aswell as ALL other variables and functions declared  in the global scope. When the function is invoked, if the js engine finds a variable in the function body not declared locally, it goes to the first outer scope, and continues going up the chain until it finds the variables declaration. If it does not find the declaration the variable is treated as a global variable.

NOTE: 
  - what matters in scope chain is where the function is declared, NOT where it is invoked.
  - all variables/functions declared in outer scopes are available in inner scopes.
	- an outer scope does NOT have access to variables/functions declared in inner scopes.


```javascript
const globalVar = 1;

function firstFunc () {
  const firstVar = 2;

  function secondFunc () {
    const secondVar = 3;

    return secondVar + firstVar + globalVar;
  }

  const resultFromSecondFunc = secondFunc();

  return resultFromSecondFunc;
}

firstFunc();
//=> 6
//=> variables/functions in secondFunc are not visible in firstFunc
```

**Code Execution**


```javascript
const myVar = 'Some string';

function myFunc(){
	return 'another string';
}
```

The js engine performs this in two separate phases, each time the engine steps through the code line-by-line:
compilation:
- for variables the engine allocates memory and set's up a reference to the variable's identifier, e.g. `myVar'. The variable is NOT initialised and has a value of undefined.

- for functions
	- function is loaded into memory and a referenceto the function's identifier, e.g. myFunc, is created.
	- a new execution context with a new scope is created
	- adds a reference to the parent scope's scope chain making the outer environment available to the new function's scope.

execution: runs the code, assigning values to variables and invoking functions. The engine will match values to coresponding identifiers in memory, looking in the current scope and then moving up the scope chain. The engine stops when a match is found. Because of this we can use the same identifier to declare a variable/function in multiple scopes. If no match is found a `ReferenceError` is thrown - variable not declared. 


**Lexical Scoping**

Lexical scoping refers to where in the code a function is actually declared, or written. The js engine does not care where a function is invoked, only where it is declared.


```javascript
const myVar = 'Foo';

function first () {
  console.log('Inside first()');
  console.log('myVar is currently equal to:', myVar);
}

function second () {
  const myVar = 'Bar';
  first();
}

// calling second
second();
//=> 'Inside first()'
//=> 'myVar is currently equal to: FOO'
//=> undefined
```

The assignment of 'myVar = Bar' is not visible to first() function because second() is not in the first() functions parent scope. They are both found in the same global scope, with the global scope as parent, but they're not in the same scope chains.

[lexical scoping](lexical_scope.png)
'myVar' variable does not exist in the first() function, so it looks in it's outer scope, the global scope where it find it. 

```javascript
const myVar = 'Foo';

function second () {

	function first () {
    console.log('Inside first()');
    console.log('myVar is currently equal to:', myVar);
  }

  const myVar = 'Bar';

  first();
}
```

If we place the first() function in second(), it's lexical scope changes, it now finds 'myVar' in the second() function, it's immediate outer scope is now the second() function.


**First Class Functions**

Re-cap statements vs expressions
- statement -> unit of code that does someting
- expression -> unit of code that produces a value

First-class functions can:
- be assigned to a variable as a value
- be passed to a function as an arg
- can be returned from a function as a value
- can be stored as a data structure, as elements within an array or as properties of an object.


**Common Javascript Errors**

`Uncaught ReferenceError: xxxxx is not defined`
- one of the most common, you've tried to reference a variable or function that could not be found in the scope chain.
- also occurs if you don't add quotes around a string - js engine interprets this as a variable reference, which does not exist.

`Uncaught TypeError: xxxxx is not a function`
- you've tried to invoke an object that is not a function, i.e. not invokable.

`Uncaught SyntaxError: missing ) after argument list`
- you've tried to invoke a function but forgot the closing paranthesis, e.g. myFunction(2, 4;


`Uncaught TypeError: Assignment to constant variable.`
- you've tried to assign a new value to a variable declared with the `const` keyword.


When an error is thrown it is passed up the call stack, all the way to the global execution context, waiting for something to catch it. Javascript prides the `try...catch` block with which you can run js statements and try and catch any resulting errors.



**Chrome browser errors**

If you run javascript in the Chrome's js console you may see errors like the following:

```javascript
// ERROR: Uncaught TypeError: Assignment to constant variable.
//  VM5412:3  at <anonymous>:3:20 (anonymous) @ VM5412:3
```

The `VM` standards for Virtual Machine, and it's Chrome's way of saying that the script didn't run in a specific file. In this case, the script ran in the JavaScript console, and Chrome arbitrarily assigned an ID of `5412` to the execution of that particular script. If you run the same code again, the number will have changed because Chrome's treating it as a new script execution and will assign it a new ID number.

The `:3` piece of `VM5412:3` is, however, interesting. It's telling us which **line** within the script caused the error. In this case, it happened on the third line.

The `at <anonymous>:3:20` message elaborates on the `:3`, indicating that, not only was the error on the third line, it was on the 20th **character** of the third line. The `<anonymous>` is, like the `VM` designation, telling us that the error didn't occur in a specific file.

The only new piece of information on the final line is `(anonymous)`, which is slightly different from the `<anonymous>` above. While `<anonymous>` indicates that we aren't in a particular file, `(anonymous)` tells us that we're in the global scope — that the error didn't occur inside of a function.


**Hoisting**

With ES6/2015 you can simply do the following:
- ALWAYS use `let` and `const` for declaring variables and function expressions.
- declared functions should be placed at the top of their lexical scope, e.g global functions at the top of the js file, nested functions at the top of their parent function.
- if you need to decclare a variable with `var`, declare it at the top of it's scope before it's used.

Hoisting is the result of the two phase way in which the js engine executes js code. In the compilation phase declared functions are loaded into memory, in the 2nd, execution phase they are invoked. This means you can call a function before it's declared.

NOTE: variables declared with `let` and `const` ARE hoisted, the js engine simply does not allow them to be referenced before they're initialized - causes the `ERROR: Uncaught ReferenceError: xxxxx is not defined`



 ## Data Structures in Javascript


**Arrays**

- simplest data structure in javascipt
- elements can be any datatype, mixed.
- the elements are ordered, they always appear in the same order
- access elements via bracket notation
- destructively add (push(), unshift()) and remove (pop(), shift()) elements

SPREAD OPERATOR
We can non-destructively add elements to an array - creating a new array and pressering the old using the ES6/2015 `spread operator` - `...` adding elements either to the begining of the array or the end - added as individual values, not as a whole array.

```javascript
// adding elements to the begining of an array
const coolCities = ['New York', 'San Francisco'];
const allCities = ['Los Angeles', ...coolCities];

coolCities;
// => ["New York", "San Francisco"]
allCities;
// => ["Los Angeles", "New York", "San Francisco"]

// adding elements tot he end
const coolCats = ['Hobbes', 'Felix', 'Tom'];
const allCats = [...coolCats, 'Garfield'];

coolCats;
// => ["Hobbes", "Felix", "Tom"]
allCats;
// => ["Hobbes", "Felix", "Tom", "Garfield"]
```

SLICE()
We can non-destructively remove elements from an array using the `slice()` method.
- calling `slice()` with no args returns a copy of the original array.
	- primitive values in the array are copied - change one in one array and it's not changed in the other array.
	- objects in the array are not - if you make a change to on of the objects in the original array, it's changed in the copy also. js copies the references to the objects, not the objects.

- we can pass two args to `slice`, first is the element to start at, the second(which is optional) is the index to stop(up to but not including that value). Without the second arg, copy continues to the end.
- if we provide a negative index, slice starts from the end.


SPLICE()
Removes elements destructively - mutates the orignal.
- passing a single argument - marks the starting point. Returns a new array containing the removed elements, the original is mutated with those elements removed.
- passing two args - 2nd arg is the number of elements to remove, begining from start.
- passing in 3 or more arguments, and every additional arg will be inserted into the original at the start position. An array of the removed elements is returned. If the second arg is 0, we will not remove any elements.


FILTER()
Used to filter arrays, returns an array that contains the elements that matched the condition. Filter delegates the actual comparison to a function you pass to filter.

```javascript
const numbers = [1,2,3,4,5,6,7,8,9];
const matches =  numbers.filter(val => val % 2 === 0);


// custom filter function should iterate over the collection passing each elm in turn to the callback
function filter (collection, callback) {
	const newCollection = [];
  for (const elm of collection) {
    if (callback(elm)) {
      newCollection.push(elm);
    }
  }
	return newCollection;
}

// customise the callback for each particular case
function callback(elm){
	return elm >= 5;
}
```

MAP()
Iterates over every element in an array, transforming the element before return the elements in a new array. `map()` delegates transforming the array elements to a callback function, which is passed to map as the sole argument.
- map passess the elm, it's index and a copy of the array on each iteration to the callback function.

```javascript

// creating a custom mapping function
function map(collection, callback){
	const newCollection = [];
	// iterate over array and pass elm to callback
	for(const elm of collection){
		collection.push(callback(elm));	
	}
	return collection;	
}

// transform the value
function callback(elm){
	return elm * 2;
}
 ```

FOREACH()
Iterates over every element in the array once, taking one argument - the callback function, to which it delegates the action to be performed to the element.
- like `map()`, `forEach()` passes the elm, it's index and the array.

```javascript

// creating a custom forEach
function myForEach(arr, cb){
  for(const elm of arr){
    cb(elm, arr.indexOf(elm), arr);
  }
}

function callback(elm, i, array){
  // do some thing
}

```

SORT()
Sorts arrays 'in-place' - destructively re-arrange the elements in the original array.
- works by coercing each element into a string and comparing the Unicode value of each character, 'A' comes before 'B'.
- fine if all you're sorting are strings of the same case.
- sort takes one arg, a callback, which you can use to customise it's behaviour.
- the callback(comparator) itself takes two elements which it compares each time the comparison is invoked

```javascript
// sort strings
const array = ['John', 'ian', 'brian', 'Bob', 'Simon', 'adam'];

function comparator(a, b){
  return a.localeCompare(b);
}

array.sort(comparator);
//=> [ 'adam', 'Bob', 'brian', 'ian', 'John', 'Simon' ]


// sort numbers
const numArray = [0,12,2,1,5,10,23,4,56,32];

// sort numbers in ASC order
function ascComparator(a, b){
  return a - b;
}

numArray.sort(ascComparator);
//=> [ 0, 1, 2, 4, 5, 10, 12, 23, 32, 56 ]


// sort numbers in DESC order
function descComparator(a, b){
  return b - a;
}
numArray.sort(desComparator);
//=> [ 56, 32, 23, 12, 10, 5, 4, 2, 1, 0 ]
```

READUCE()
Iterates through an array, applying a callback function against an accumulator and each element in turn, reducing the array to a single value.
- it takes two args, the callback function and the initial value.
- to sum a series of values, the initial value would be 0.
- to reduce an array of values to a single object, pass in {}.
- to reduce an array of objects to a simpler array of values, pass in [].

The callback function takes four args:
- the reduced value as it curently stands/initial value,
- the current element,
- it's index, and
- the original array.

```javascript
const products = [
  { name: 'Head & Shoulders Shampoo', price: 4.99 },
  { name: 'Twinkies', price: 7.99 },
  { name: 'Oreos', price: 6.49 },
  { name: 'Jasmine-scented bath pearls', price: 13.99 }
];

const stringify = function (agg, el, i, arr) {
  let stringifiedElement = el.name + ' is $' + el.price + '. ';

  if (i === arr.length - 1) {
    stringifiedElement += 'The total price is $' + (agg.totalPrice + el.price) + '.';
    return agg.string + stringifiedElement;
  }

  return {
    string: agg.string + stringifiedElement,
    totalPrice: agg.totalPrice + el.price
  };
};

products.reduce(stringify, { string: '', totalPrice: 0 });

// => "Head & Shoulders Shampoo is $4.99. Twinkies is $7.99. Oreos is $6.49. Jasmine-scented bath pearls is $13.99. The total price is $33.46."
```



**Objects**

In javascript objects are a collection of key/value pairs bounded by curly braces.
- access/set property values using dot/bracket notation
- all keys are strings - use camelCase, with no spaces or punctuation
- use bracket notation when defining non-standard key, .e.g  string with spaces or other puntuation, or accessing a dynamic property, e.g. when iterating over an object and when programmatically accessing and assigning properties.

```javascript
const name = 'my name'
obj.name //=> property set to 'name'
obj[name] //=> property set to 'my name'
```

Bracket notation is useful when we need to compute the value of variables on the fly:

```javascript
const meals = {
  breakfast: 'Oatmeal',
  lunch: 'Caesar salad',
  dinner: 'Chimichangas'
};

let mealName = 'lunch';

meals[mealName];
// => "Caesar salad"

// if we try to call the 'mealName' property using dot notation
meals.mealName
//=> undefined, the object has no propert with that identifier
```

Assigning properties using dot/bracket notation is destructive, it overwrites the value if it already exists. We can non-destructively assign properties to objects using ES2015 spread operator and Object.assign().

SPREAD OPERATOR
- copy all the objects's properties into a new obj, old remains unchanged

```javascript
const obj = {
  name: 'Max',
  age: 23
}

// newObj is a clone of obj, we can now change or add new properties to newObj
const newObj = {
  ...obj
}

newObj.name = "peter';
newObj.gender = 'male';
newObj['age'] = 45;
```

OBJECT.ASSIGN()
- method of the global `Object` object
- merge the properties of two or more objects into the initial object
- set the initial object as {} to create a new obj, other objects are unchanged.
- if multiple objects have the same key, the last applied wins out.
- use this method to clone objects, create a clone with new properties, or change an objects properties
- 

```javascript
const newerObj = Object.assign({}, obj, newObj, {street: '1 the street', city: 'London'});
```

OBJECT.KEYS()
- returns an array of all the top level keys of the object passed in as an argument.
- the sequence of the keys in the returned arrray varies between browsers

NOTE: any keys of objects declared as values of top level keys are NOT returned.


DELETING PROPERTIES
- use the `delete` operator

```javascript
delete newerObj.age;
delete newerObj['street'];
```

**Looping and iterating**

Looping is the process of executing a set of statements repeatedly until a condition is met. In javascript we have `for` and `while` loops.
- use `for` loops when you need to repeat the process for a set number of times
- use `while` loop when there is no set number of times, loop while a condition holds true. Make sure the condition updates every iteration o make sure the loop terminates.

Iteration is the process of executing a set of statements once for each element in a collection. Prior to ES2015 `for` and `while` loops were used. 

ES2015 introduced the `for...of` statement to iterate over arrays:

```javascript
const myArray = ['a', 'b', 'c', 'd', 'e'];

for(const element of myArray){
  console.log(element);
}
```

There's no need to initialize a counter, increment it, check a condition, or use bracket notation to access the array element. We can use `const` instead of `let` since each iteration we're assigning a new array value to the element variable.

NOTE: we can also use `for...of` to iterate over strings, since they are array's of characters.


ES2015 introduced the `for...in` statement to iterate over objects:

```javascript
for(const <KEY> in <OBJECT>){
  // do something
}
```

`for...in` passes in each object key in turn, you can use bracket notation to access each value in turn. dot notation does not work(returning undefined), returning undefined since there are no properties on the object called 'key'

```javascript
const address = {
  street1: '11 Broadway',
  street2: '2nd Floor',
  city: 'New York',
  state: 'NY',
  zipCode: 10004
};

for (const key in address) {
  console.log(key); //=> returns the key
}

for (const key in address) {
  console.log(address[key]); // returns the value
}
```

NOTE: DO NOT use `for...in` to iterate over arrays. Arrays are ordered objects, so we would expect to iterate over the elements in order. `for...in` is not guarenteed to iterate over the elements in order.


ITERATING OVER NESTED ARRAYS AND OBJECTS

the `for...of` and for...in` statements iterate over the top level elements of an array or object. In order to traverse over nested arrays and objects we have to user recursion. A recursive function is one that calls itself.

```javascript
function deepIterator (target) {
  if (typeof target === 'object') {
    for (const key in target) {
      deepIterator(target[key]);
    }
  } else {
    console.log(target);
  }
}
```

When we invoke deepIterator() with an argument, the function first checks if the argument is an object or array (recall that the typeof operator returns "object" for arrays as well). 
If the argument isn't an object, deepIterator() simply console.log()s out the argument and exits. 
However, if the argument is an object, we iterate over the properties (or elements) in the object, passing each to deepIterator() and re-invoking the function.


**Creating Objects with Constructor Functions**

Using object literals and setting properties results in a lot of repeated code. Using the `constructor function` we can create objects with the same attributes while assigning different values to those attributes.
- by convention the name is capitalized
- needs to be called with the `new` keyword - results in an object being created, properties set on that object and the object being returned.
- NO explicit return is required
- use the args passed in to set the obj's attributes
- `this` is set to the actual object, allowing us to reference the object being instantiated inside the function.

ADDING BEHAVIOURS

We could define methods in the constructor function itself, e.g.

```javasctipt
function User (name, email){
  this.name = name;
  this.email = email;
  this.info = function(){
    return `my name is ${this.name}`;
  }
	this.details = ()=>{
		return `my age is ${ this.age }`;
	}
}

//=> when defining methods in the actual constructor, whether using the classical function(){} syntax or ES2015 arrow function syntax, `this` is set to the object, so prperties resolve properly.
```

Using PROTOTYPES is the preferred technique. In the technique above every object instantiated from the constructor will posses a copy of each defined method(the objects posses an actual copy of each method and not merley a reference to a shared method), increaing it's memory footprint.
- every instantiated object has a reference to every method defined on the `prototype`


```javascript
User.prototype.info = function(){
  return `my name is ${this.name}`;
}

// this does not work -> `this` is undefined
User.prototype.details = ()=>{
	return `my age is ${ this.age }`;
}
```

**Creating Objects using Classes**

The `class` keyword introduced in ES2015 uses function constructors and prototypes to create objects and define their methods - it's just an abstraction to make things easier, 'syntactic sugar'.
- we now have a constructor which is run each time a new object is instantiated.
- methods are declared in the class (defines the method on the Objet's prototype) - the word `function` is not used.
- objects are instantiated in the same way as before with the `new` keyword.

```javascript

class User {
	constructor(name, email){
	  this.name = name;
  	this.email = email;
	}

  info(){
    return `my name is ${this.name}`;
  }
}

const tom = new User('tom', 'tom@ex.com');
```

**Inheritance with Classes**

One class can inherit from another through the `extends` keyword.
- the new class inherits all the methods of it's 'parent'
- is initialized with the same properties
- we can override the parent's methods by defining another method with the same name, plus declare new ones.
- we can also override those methods while calling the method of the `superclass` using the `super` keyword. This preserves the behaviour of the parent, while adding to it.

```javascript
class Teacher extends User {

	info(){
		// return `my name is ${ this.name }, I teach Math`;
		return `${ super.info() }, I teach Math`;
	}

	teachMath(){
		return 'I teach Math';
	}
}

const teacher = new Teacher('sam', 'sam@ex.com');
```

