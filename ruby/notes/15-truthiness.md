# Truthiness

## Overview

In this lesson, we'll explain the significance of truthiness in programming and identify boolean values in Ruby. 

## Objectives

1. Define control flow and how Boolean values help in implementing it in programming.
2. List what is truthy and falsey in Ruby.
3. Use the double bang operator to determine truthiness in Ruby. 

## Introduction

![Truthiness](http://upload.wikimedia.org/wikipedia/en/thumb/8/85/Truthiness.png/300px-Truthiness.png)

Many programming languages, including Ruby, have native boolean (true or false) data types. In Ruby they're expressed directly as `true` and `false`.

**Advanced:** *This is not the case in all languages. In Python, boolean values are capitalized,* `True` *and* `False`, *while in Objective-C they are different words* `YES` *and* `NO`. *However, they all represent the same concept of Boolean logic.*

These boolean values come in handy in programming when we want to implement control flow. Control flow is the idea that we can tell our program to execute certain lines of code based upon certain conditions.

### Booleans and Flow Control

For example, *if* I am tired, then I will take a nap. Otherwise, I will keep reading this insightful and informative readme. You could also invert the perspective like in this example:

If it is *true* that I am tired, then I will take a nap. If it is *false* that I am tired, then I won't take a nap.

Flow control is predicated on these true-or-false boolean values. The adjectives "truthy" and "falsey" are a programming convention for describing the *state* of being true and the *state* of being false.

What this example amounts to is this: we want to be able to use non-boolean values (like strings or integers) in a boolean context; we want to be able to say, "*if* a certain statement *evaluates* to true (or is "truthy"), then execute these certain lines of code."

Consequently, Ruby must have a way of determining what counts as true at a given moment—or what is "truthy" versus what is "falsey".

Remember, don't worry about understanding control flow and implementing it right now. This is just to provide some background about why we care about the concept of truthiness in Ruby.

## What Is 'truthy' and 'falsey' in Ruby?

Programming languages are software, too! That means the people who built Ruby had to decide what is truthy and what is falsey. Different languages make different decisions.

**In Ruby only false and nil are falsey. Everything else is truthy (yes, even 0 is truthy).**

Become familiar with the following chart:

| Value        | Truthy? |
|:------------:|:-------:|
|0             | yes     |
| " "          | yes
|"hello"       | yes     |
|nil           | no      |
|6.7           | yes     |
|true          | yes     |
|false         | no      |
|[1,2]         | yes     |
|{:hi=>"there"}| yes     |

You get the idea!

**Top-Tip:** Even an empty string, `" "`, is truthy! This might seem kind of strange, but it will make more sense once we learn more about object orientation. For now, keep in mind that even an empty string is an instance of the String class. Again, that sentence might not mean a lot to you right now, but it will soon...

### Bonus: Determining Truthiness

If you forget to memorize this handy chart, there is a trick you can use to determine if a value is truthy or falsey.
A **single bang operator**, `!`, will negate the boolean value it is placed in front of. For example:

```ruby
!true  #=> false
```

and

```ruby
!false #=> true
```

**The double bang operator:** A "double-bang operator" (`!!`) will return `true` or `false` based on whether a value is truthy or falsey to begin with.

For example:

```ruby
!!"hello" #=> true

!!nil #=> false
```

## Resources
* [JFarmer's Gists](https://gist.github.com/jfarmer/) - [Truthy and Falsey in Ruby](https://gist.github.com/jfarmer/2647362)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/truthiness-in-ruby-readme' title='Truthiness'>Truthiness</a> on Learn.co and start learning to code for free.</p>
