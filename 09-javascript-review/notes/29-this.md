# JavaScript This

## Overview

We'll introduce the `this` keyword and use it in various ways. 

## Objectives

1. Explain how `this` refers to the "owner" of a function
2. Use `this` to refer to an object that called a function
3. Use `this` to refactor event handlers
4. Explain how `this` refers to different objects based on scope

## Introduction

It's often important in programming to know what the "owner" of a function is so that we can operate on some specific object or data safely.

For instance, consider an event handler that fires when someone clicks on a link in the DOM. When that event handling function is invoked, we might want to know *which specific* link was clicked so that we can manipulate it in some way.

That's where the `this` keyword comes into play. Every function is automatically assigned a `this` value when called, and that represents "who" called the function. This value can be an object, an event, or even another function.

The value of `this` is determined by the *execution context*, or scope, of the function call.

## Global Scope

Code running outside of a function is in the **Global Scope**. Every JavaScript runtime has a default global object that will be the value of `this` when a function is called in global scope. In the browser, if we're referencing `this` in the global scope, we're referencing the `window` object.

Try adding the following code to `script.js` and then run `index.html` in your browser with the JavaScript console open:

```js
console.log(this === window);
// returns true
```

Here, we called `this` in the global scope, so the value of `this` was set to the default global object, `window`, when the function was invoked.

## Function (Local) Scope

Inside of a function, the value of `this` will be set based on how the function is called.

### Simple Function Call

Add the following to `script.js` and refresh the page with the console open:

```js
function checkThis(){
  console.log(this);
}
checkThis();
// outputs window object
```

This will also output the `window` object because this simple function call doesn't set the `this` value. Because we aren't in *strict mode*, the value of `this` must be an object, so the default global object `window` is used.

**Advanced:** Strict mode is a setting that enables better error-checking in your code by prohibiting the use of implicitly declared variables, duplicate parameter names, and other potentially bug-causing behavior. Strict mode also converts some silent execution errors into not-so-silent ones. For more information, check out the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Strict_mode).

Let's put our function in strict mode:

```js
function checkThis(){
  'use strict';
  console.log(this);
}
checkThis();
// outputs "undefined"
```

In strict mode, `this` remains at whatever it's set to when entering the execution context. If it's not defined, it remains undefined rather than being assigned the default `window` object.

### Constructor Function Call

When we use the constructor function pattern to create objects, we make use of `this` to assign property values to the instance of the object being constructed.

```js
function Chair(style, color) {
  console.log(this);
  this.style = style;
  this.color = color;
}
var sofa = new Chair("sofa", "green");
```

Here, because we're calling `Chair()` with the `new` keyword, `this` refers to the new `Chair` object. So when you see `this.style = style;` you can think of it as saying "set the style property of THIS current instance of a Chair."

In your console, `this` will be an empty Chair object because we haven't assigned the property values yet when we output `this`, but try moving that `console.log(this)` to the end of the function and see what you get!

### Object Function Call

Objects can have functions as well as properties. When a function is an attribute of an object, `this` is set to the object instance that contains the function, similar to how it works with a constructor function.


```js
var couch = {
  color: 'green',
  f: function() {
    return this;
  }
};

console.log(couch.f());
// outputs object
```

**Top-tip:** Notice that this only outputs an `Object` and not something called `couch`? That's because `this` is just an instance of the base `Object` type here, and `couch` is just the name of the variable holding that object instance. The object itself is the owner of the function and has no idea what you named it.

### DOM Events

We can also make use of `this` when handling events on the DOM. If our `index.html` has three image elements with the same CSS class, we might need to know which specific `img` was clicked.

```html
<img class="pix" src="http://i.giphy.com/S1phUc5mmaZqM.gif">
<img class="pix" src="http://i.giphy.com/eGe59ekUJEll6.gif">
<img class="pix" src="http://i.giphy.com/l41lNT5u8hCI92nQc.gif">
<script type="text/javascript" charset="utf-8">
    var els = document.getElementsByClassName("pix");
    function handleClick(e) {
      console.log(this);
    }
    for(var i=0 ; i < els.length ; i++){
      els[i].addEventListener("click", handleClick, false);
    }
</script>
```

Here, when we click a given image, we see that `this` refers to that specific DOM element, so, if we wanted to do something like hide it or apply some other class to it, we could safely do so on just that one element.

## Summary

We learned that we can use the `this` keyword to understand who the "owner" of a function is, and how the execution context of the function call affects the value of `this`. We also saw how to use `this` in objects and when manipulating the DOM to ensure that we are operating on only the specific objects that we intend to.

## Resources

+ [MDN This](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this)

+ [JavaScript is Sexy](http://javascriptissexy.com/understand-javascripts-this-with-clarity-and-master-it/)

+ [StackOverFlow This Quiz](http://stackoverflow.com/questions/3127429/how-does-the-this-keyword-work)

