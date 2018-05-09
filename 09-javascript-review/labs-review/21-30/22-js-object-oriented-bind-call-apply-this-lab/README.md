# Bind, Call, Apply Lab

## Objectives
+ Use JavaScript's bind, call, and apply methods to change function's scope and properly pass arguments


## Instructions

In this lab, our *tests* define functions that are then passed through to functions we ask you to write.  Your functions should not only invoke the functions passed as arguments, but also modify the `this` value of the functions passed through while ensuring arguments are properly passed.   

We ask you to write the following functions:

  + `justInvoke(fn)`: The function simply invokes the function passed through to it.  It also returns the return value of the passed through function.  
  + `setThisWithCall(fn, thisValue, arg)`: The function again invokes the function passed to it, but uses the `call` method to return the function's this value. (Make sure to correctly pass the third argument!)
  + `setThisWithApply(fn, thisValue, args)`: Again, invoke the function passed to it, change the `this` value of that function passed to it.  In addition, we ask you to invoked the passed function with arguments.  You should accomplish all of the above by using `apply`.
  + `returnNewFunctionOf(functionToBeCopied, thisValue)`: Here, we ask you to write a function that returns a copy of the function passed through, but sets the `this` value of the function's copy.

<p class='util--hide'>View <a href='https://learn.co/lessons/js-object-oriented-bind-call-apply-lab'>Javascript Bind, Call and Apply Lab</a> on Learn.co and start learning to code for free.</p>

*Don't forget to make use of MDN's call and apply documentation!*

[MDN Call](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)

[MDN Apply](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
