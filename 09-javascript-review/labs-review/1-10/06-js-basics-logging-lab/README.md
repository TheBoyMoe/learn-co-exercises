# JavaScript Logging Lab

## Objectives
1. Practice using `console.log()`

## Introduction
Another JavaScript lab! In this lab, we are practicing our use of `console.log` to debug in JavaScript.

Remember the workflow:
1. Run `learn`.
2. Read the errors; vocalize what they're asking you to do.
3. Write code; repeat steps 1 and 2 often until a test passes.
4. Repeat as needed for further tests.
5. Run `learn submit` when finished!

## Working through these tests
+ `driver` - This test is already working for you. If you look inside the `it` function you will see that the first test expects a variable named `driver` to have a value of `bob`. When you open up the `index.js` file, you will see that this already is declared in the first line.
+ `console.log()` - Let's take a look at the second `describe` function call inside of `test/indexTest.js`. Here, you can see that the tests inside of here are asking for a few things. Let's take them in turn.
  * If you look at the first `it` function call, the tests ask that `invokes console.log() with the string "this code was called"`. Then, the next line says `spy` to be `calledWithExactly` the string `this code was called`. To pass this test, we can write `console.log('this code was called')` inside of our `index.js` file. Yes, I know we are a little confused. What is a spy? It's ok if you walk away from the course not knowing. Just understand that here we are using this `spy` thing to test that `console.log` is called, and what arguments it is passed to. So whenever you see `expect(spy.calledWithExactly('this code was called')).to.be.true` what we really mean is that we expect `console.log` to be called with the argument `this code was called`. For more details on what the `spy` is doing, see our "note about spies" below.
  * In the second to last `it` function call in `test/indexTest.js` we test that `console.log` is called with our `driver` variable. This is a task you may find yourself doing a lot. Using `console.log` to see the value of a variable. If you pass the `variable` driver to `console.log` your test should be passing. More to the point, if you open up your browser's console (by pressing cmd+shift+c on a mac), you can see your corresponding data logged.
  * The final `it` function call in this lab, the test asks you to practice passing multiple arguments to `console.log`. The first argument is the `driver` variable, and the second argument should be the string `is the driver variable name`.

## A note about spies
You might often see errors like the ones above: `"Uncaught error: spy was not
called"`. Spies are little bits of code that keep track of whether or not they
were called. Here, we are ensuring that `console.log` was called - so if you see that error it means that you are not properly calling that `console.log` function.

Why are we using spies all of a sudden? Open up the `test/indexTest.js` file and let's see how they work, and learn why we are using this feature. Underneath the code `describe('console.log', function () { ...`, you can see the code `spy = sinon.spy(console, 'log');`. This asks our tests to watch the `console.log` function. Later on in an `it` block, we can ensure that `console.log` is called, and can see what arguments it is called with. We are using the `spy` because, well how else can we tell you are calling this function? The function returns `undefined` after all, so we can't really check the return value of your code, and `console.log` affects your browser's console, which we can't easily read. So we just test to make sure you made use of this function, and to do so we use a spy. If this was confusing to you, it is not a core JavaScript topic nor is it a prerequisite to learning more with JavaScript, so you can happily move ahead.

## Resources
- [console.log](https://developer.mozilla.org/en-US/docs/Web/API/Console/log)

<p class='util--hide'>View <a href='https://learn.co/lessons/js-basics-logging-lab'>Logging Lab</a> on Learn.co and start learning to code for free.</p>
