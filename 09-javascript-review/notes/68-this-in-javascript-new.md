# JavaScript This Walkthrough

## Objectives
+ Understand how `this` depends on the invocation of a method

## Deep Dive into This

JavaScript's `this` keyword can sometimes be unpredictable. Now that we are going deeper into object oriented code, we should discuss it with the detail that it deserves.  So let's explain our rule to know what `this` is.  Our rule is simple:   

**If this is referenced directly inside a method, it equals the object that received the method call.  Otherwise this is global**

The rest of this lesson will show all of the twists and turns we can encounter in strictly applying the above rule.  But first, let's make sure we properly define the word *method*.  A JavaScript method is a property on an object that points to a function.  So just like we can write `let person = {name: 'bob'}`, whereby the `name` property points to a value of `'bob'`, we can also write the following:

```javascript

let person = {
  greet: function(){
    console.log('hello')
  }
}

typeof person.greet
// 'function'
```

And have the `greet` property point to a function.  Because this `greet` property on our object points to a function, we call the property a method.  Ok, so because the `greet` property is a method, we know that when we call `person.greet()` the object receiving the method call equals `person`.  Let's modify our `greet` function and see that:

```javascript

let person = {
  greet: function(){
    return this
  }
}

typeof person.greet
// 'function'
person.greet() == person
// true
```

We see that `person.greet()` returns `this`, which refers to the object that received the method call.

### Watching this change

Ok, hang on tight, because we are about to see something weird.  Let's modify the code above slightly:

```javascript

let person = {
  greet: function(){
    return this
  }
}

person.greet() == person
// true

let greetFn = person.greet

greetFn() == person
// false
greetFn()
// window

person.greet() == person
// true
```

Ok, so let's walk through the code above.  We set our `greet` property on the `person` object to point to the same function, and see that when we call `person.greet()`, `this` refers to the `person` object.  The tricky part happens when we write `let greetFn = person.greet`.  What this does is assign a local variable `greetFn` to refer to the function on the `person` object.  However, this local variable **does not** refer to the `person` object at all.  It has zero knowledge of the `person` object.  It *only* points to the function.  Then we invoke the function by calling `greetFn()`.  In doing so, we are not calling the property on the object, we are simply invoking the function, making `this` global - or in the context of the browser, `window`.

### Functions within Functions

Let's see another occurrence where `this` becomes global, by invoking functions within functions.  Let's change our code to look like the following:

```javascript

let person = {
  greet: function greeting(){
   function otherFunction(){
     return this
   }
   return otherFunction()
  }
}

```

Ok, let's walk through what the above code is doing.  Our object, `person` has a property `greet` that points to a function called `greeting`.  Now when our method `greet` is called, it first declares and then invokes the `otherFunction` function.  The `otherFunction` returns `this`, which is returned by the `greet` method.  So what does this equal.  Well, note that `this` **is not** referenced directly inside a method.  This is because `otherFunction` is not a method, but a function.

Remember, a method is a property that points to function.  If we call the `person.greet` property, it returns the `greeting` function, not `otherFunction`.  Because no property on an object points to `otherFunction`, `otherFunction` is not a method, and as `this` is referenced in our non-method, `this` is global, or the window.

```js

  person.greet()
  // window
```

So as you see from the above examples, we sometimes reference `this` from functions, not methods.  When that occurs, `this` is not referenced from inside a method, it is global.

### This and Callbacks

Now we have seen functions call other functions whenever we use a callback.  And it's worth reminding ourself that many out of the box JavaScript functions are passed callbacks.  So if we did something like the following:

```js
  [1, 2, 3].filter(function(element){
    console.log(this)
    return element%2 == 0
  })
  // window
  // window
  // window
```

Each time our callback function is invoked, `this` is global.  Do you see why?  Our function is invoked by the `filter` method.  Filter is a method.  We can invoke it as a property on our array.  However, the callback function is not called as a property on an object, and thus when we reference `this` from inside the callback function, `this` is the window, or global scope.

### Summary

The above lesson displayed how `this` changes depending on whether it is referenced from inside a method or a function.  We saw that even if a function was originally declared as a property on an object, if we do not reference the function as a method, `this` will be global.  We also saw that when a function invokes another function, from the inner function `this` is global.  Finally, we showed how callback methods are a specific application of an inner function being called, and therefore `this` is also global inside of callbacks passed to our array iterator methods.
