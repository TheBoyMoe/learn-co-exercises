# JavaScript Data Types
In this lesson, we'll cover all of the basic data types in JavaScript.

## Objectives
1. Define 'data type'.
2. Perform basic type checking with the `typeof` operator.
3. Provide a high-level overview of JavaScript's seven basic data types.
4. Discuss interactions between data of various types in JavaScript.

## What is a data type?
At the machine level, all data on a computer are bits — 1s and 0s. Humans, it turns out, have more trouble discerning between `1100011 1100001 1110100 1110011` and `1100100 1101111 1100111 1110011` (cats and dogs) than our silicon friends. For more human-friendly representations of different pieces of information, we developed **data types**. JavaScript contains a number of operators (`+`, `!`, `<=`, etc.) and reserved words (`function`, `for`, `debugger`, etc.), which are reserved by the language for a specific purpose. ***Everything else is data***. And every piece of data falls into one of JavaScript's seven data types: numbers, strings, booleans, symbols, objects, `null`, and `undefined`.

***NOTE***: Throughout this lesson, we'll use the `typeof` operator to give us an idea of what data types we're dealing with. `typeof` accepts one argument, the piece of data that we'd like to know the _type of_.

### Numbers
Unlike other programming languages that divide numbers up into integers, decimals, doubles, floats, and so on, JavaScript only has a single, all-encompassing `number` type:
```js
typeof 42
//=> "number"

typeof 3.141592653589793
//=> "number"

typeof 5e-324
//=> "number"

typeof -Infinity
//=> "number"
```

### Strings
Strings are how we represent text in JavaScript. A string consists of a matching pair of `'single quotes'`, `"double quotes"`, or `` `backticks` `` with zero or more characters in between:
```js
typeof "I am a string."
//=> "string"

typeof 'Me too!'
//=> "string"

typeof `Me three!`
//=> "string"
```

Even empty strings are strings:
```js
typeof ""
//=> "string"
```

### Booleans
A boolean can only be one of two possible values: `true` or `false`. Booleans play a big role in logical control flows and looping in JavaScript.
```js
typeof true
//=> "boolean"

typeof false
//=> "boolean"
```

### Objects
JavaScript objects are a collection of properties bounded by curly braces (`{ }`), similar to a hash in Ruby. The properties can point to values of any data type — even other objects:
```js
{
  "name": "JavaScript",
  "createdBy": {
    "firstName": "Brendan",
    "lastName": "Eich"
  },
  "firstReleased": 1995,
  "isAwesome": true
}

typeof {}
//=> "object"
```

### `null`
The `null` data type represents an intentionally absent object. For example, if a piece of code returns an object when it successfully executes, we could have it return `null` in the event of an error. Confusingly, the `typeof` operator returns `"object"` when called with `null`:
```js
typeof null
//=> "object"
```

### `undefined`
The bane of many JS developers, `undefined` is a bit of a misnomer. Instead of 'not defined,' it actually means something more like 'not yet assigned a value.' We'll learn a lot more about `undefined` when we dive into variables and functions.
```js
typeof undefined
//=> "undefined"
```

### Symbols
Symbols are a relatively new data type (introduced in ES2015) that's primarily used as an alternate way to add properties to objects. Don't worry about symbols for now.

## Primitive types
Six of the seven JavaScript data types — everything except `object` — are **primitive**. All this means is that they represent _single_ values, such as `7` or `"hello"` or `false`, instead of a collection of values.

## Interactions between data types
Every programming language has its own rules governing the ways in which we can operate on data of a given type. For example, it's rather uncontroversial that numbers can be subtracted from other numbers...

```js
3 - 2
//=> 1
```
...and that strings can be added to other strings:
```js
"Hello" + ', ' + `world!`
//=> "Hello, world!"
```

Some programming languages, such as Python, are strict about how data of different types can interact, and they will refuse to compile a program that uses types incorrectly. Other languages, such as Ruby, will attempt to handle the interaction by converting one of the data types so all data is of the same type. For example, instead of throwing an error when an integer (`3`) is added to a floating-point number (`0.14159`), Ruby will simply convert the integer into a floating-point number and correctly calculate the sum:

```ruby
3 + 0.14159
#=> 3.14159
```

JavaScript is a little _too_ nice when handling conflicting data types. No matter what weird combination of types you give it, JavaScript won't throw an error and will return _something_ (though that _something_ might make no sense at all). This runs the gamut from the halfway-defensible...

```js
"High " + 5 + "!"
//=> "High 5!"
```
...to the [comical][Wat]:
```js
null ** 2 // null to the power of 2
//=> 0

undefined ** null // undefined to the power of null
//=> 1

{} + {} // empty object plus empty object
//=> "[object Object][object Object]" <-- That's a string!
```

Why JavaScript returns a string when we ask it to add two empty objects is anyone's guess, but its heart is definitely in the right place. The language always tries to bend over backwards for its human masters, returning actionable data instead of throwing errors. However, JavaScript's eagerness occasionally results in data type issues that both novice and expert programmers have to keep an eye on.

Try to follow along with what's happening here:
```js
1 + 2 + 3 + 4 + 5
//=> 15

"1" + 2 + 3 + 4 + 5
//=> "12345"

1 + "2" + 3 + 4 + 5
//=> "12345"

1 + 2 + "3" + 4 + 5
//=> "3345"

1 + 2 + 3 + "4" + 5
//=> "645"

1 + 2 + 3 + 4 + "5"
//=> "105"
```

As long as we are only adding numbers to other numbers, JavaScript performs the expected addition. However, as soon as we throw a string in the mix, we stop adding and start concatenating everything together into a string. In the fourth example, we add the numbers `1`, `2`, and `3` together to get `6` (a number). We then ask JavaScript to add `6` (a number) to `"4"` (a string). JavaScript can't perform addition with a string, so it decides to concatenate the two operands instead, resulting in `"64"` (a string). The remaining operation, `"64" + 5`, is also between a string and a number, and JavaScript once again concatenates, giving us the final result of `"645"` (a string).

You'll encounter a lot of these weird data type behaviors throughout your JavaScript programming career, but fear not: they'll trip you up less and less often as you gain experience. Buckle up!

## Resources
- [MDN — JavaScript data types and data structures](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures)
- [Destroy All Software — Types](https://www.destroyallsoftware.com/compendium/types?share_key=baf6b67369843fa2)
- [Destroy All Software — Wat][Wat]

[Wat]: https://www.destroyallsoftware.com/talks/wat
