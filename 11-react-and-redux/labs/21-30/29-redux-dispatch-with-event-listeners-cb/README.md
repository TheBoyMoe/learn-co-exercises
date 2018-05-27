Completing our Counter Application
==============

In this lesson, you will learn the following:

* How to allow a user to execute the dispatch function by attaching dispatch to event listeners.
* The __Redux__ flow.

## Application Goal

We have built out most of the __Redux__ pattern. Don't worry, we'll review it.

For now, let's talk about what we want as a user experience. Here it is: you click on a button, and you see a number on the page go from zero to one. Click again, and you see the number go from one to two. Implementing this feature can be broken down into two steps:

1. Clicking on the button should change the state.
2. This change in state should be rendered.

## Brief Redux Review

By now, you've learned a lot about Redux, but the basic story has not changed:

`Action -> Reducer -> New State`

For example, to increase the count in our state we call `dispatch({ type: 'INCREASE_COUNT' })`. Our dispatch function calls our reducer which updates state, and then we render that view on the page.

In the previous section, we learned that by dispatching an initial action and having a default argument in our reducer, we can set up our initial state.

## Rebuild our Dispatch Function and our Reducer
Let's code out our counter application from scratch.


### 1. Start by remembering one core fact about how Redux works.

`Action -> Reducer -> New State`

Ok, let's translate that into code: if we pass an action and a previous state to our reducer, the reducer should return the new state.

```javascript
let state = {count: 0}

function changeState(state, action){
  switch (action.type) {
    case 'INCREASE_COUNT':
      return {count: state.count + 1};
      
    default:
      return state;
  }
}
```

Copy this into the `reducer.js` file. Now let's get some feedback that we did this correctly by opening up our `index.html` file in Chrome. From your terminal type `open index.html`. Now this index file has a link to the `reducer.js` file, so your code will be accessible from the console -- press `command+shift+c` to open it up. Now let's test the code by calling

```javascript
changeState({ count: 0 }, { type: 'INCREASE_COUNT' });
```

If you see a return value of `{count: 1}` then give yourself a big smile. :)

If we type in `state`, we see that it's unchanged. We need to assign our state to be the return value of our reducer each time that we call the reducer. So how do we do that? Think hard, there's no rush.

Thinking...

Thinking...

### 2. Wrap the execution of our reducer in a function that we call dispatch

We can reassign the state by adding the dispatch function to our `reducer.js` file. This dispatch function should receive an argument of action. It can access the state because it is declared earlier in the file in global scope.

```javascript
function dispatch(action){
  state = changeState(state, action);
}
```

 Now let's see if this reassigns state. Open up the `index.html` file in the browser and call `dispatch({ type: 'INCREASE_COUNT' })`. Now let's type in `state` and see if was changed. State should return `{ count: 1 }`. Hooray! More smiles. :) :)

Next problem. Our state says the count is 1, but do you think that is reflected in our HTML? Me neither. What function is in charge of that? Give it a shot. I'll be waiting with the answer when you're ready.

### 3. Use the render function to display our state.

Now we need a function called render that will place this count on the page.

```javascript
function render(){
  let container = document.getElementById('container');
  container.textContent = state.count;
}
```

When we call `render()` from the console we should see HTML that reflects the current count.

Next step is to tie this re-rendering with the dispatch function. Easy enough. Let's alter our dispatch method so that it looks like this:

```javascript
function dispatch(action){
  state = changeState(state, action);
  render();
}
```

Each time we dispatch an action we should have to update our HTML because the `render` function is also called. Now for a little refactoring. Let's have only our initial state set in the reducer. We do that by setting our initial state as a default argument to our `changeState` reducer. Go ahead and tackle it. We'll show the code below.

### 4. Use a default argument in the reducer to set the initial state.

Now our `changeState` function should look like the following.

```javascript
// let state = {count: 0}

function changeState(state = { count: 0 }, action) {
  switch (action.type) {
    case 'INCREASE_COUNT':
      return { count: state.count + 1 };
      
    default:
      return state;
  }
}
```

We are commenting out/deleting the top line where we assign the state, because dispatching an action should take care of it (it doesn't). Call `dispatch` with an action like `dispatch({ type: 'INCREASE_COUNT' })`, and we would hope that because state is `undefined`, our default argument will be passed through. The problem is that we still need to declare our state. So now our updated (working) code looks like the following.

```javascript
let state;

function changeState(state = { count: 0 }, action){
  switch (action.type) {
    case 'INCREASE_COUNT':
      return { count: state.count + 1 };
      
    default:
      return state;
  }
}
```

Call `dispatch({ type: 'INCREASE_COUNT' })` again, and we get no error. Instead we get a beautiful piece of HTML code that says the number 1 on it. Now, if instead we want to show the number zero, our default state, well we can just refresh our page, and then dispatch an action that returns the default state like so: `dispatch({ type: '@@INIT' })`. This does not increase our state, but it does return our default state and then call render.

This is what we want to do each time we open our page. So let's add `dispatch({ type: '@@INIT' })` at the end of our JavaScript file. This is where we left off previously. Our almost completed code should look like the following.

```javascript
let state;

function changeState(state = { count: 0 }, action) {
  switch (action.type) {
    case 'INCREASE_COUNT':
      return { count: state.count + 1 };
      
    default:
      return state;
  }
}

function dispatch(action) {
  state = changeState(state, action);
  render();
}

function render(){
  let container = document.getElementById('container');
  container.textContent = state.count;
}


dispatch({ type: '@@INIT' })
```

Looks good. But we're going further today. We need to make sure every time the user clicks on a button, we dispatch an action. How do you think we do that?

### 5. Integrating dispatch with a user event

So `dispatch` is responsible for updating the state and re-rendering. And we want an action to be dispatched each time a user clicks. So let's attach `dispatch` execution to a click event. It may have been a while since you attached an event handler function without __jQuery__.  Since 1) we will eventually be hooking this up with React, and 2) this project is so small, there's definitely no need to load in __jQuery here__. Here's a refresher on how things work without __jQuery__: [Events without Jquery](http://blog.garstasio.com/you-dont-need-jquery/events/)

```javascript
let button = document.getElementById('button');

button.addEventListener('click', function() {
  dispatch({ type: 'INCREASE_COUNT' });
});
```

Now every time we click, we dispatch an action of type increase. `dispatch` first calls our reducer, which updates our state. Then `dispatch` renders the updated view.

Click the button. Our application is done!

## Summary

Oh yea! Not much new here. But that didn't stop the dopamine hit. We saw that by thinking about __Redux__ from the perspective of `Action -> Reducer -> New state`, we are able to get our application going. Then it's just a matter of tackling each problem.

As for new information, we saw that we can get the user to call the `dispatch` method, by executing `dispatch` from inside the callback of an event handler.

<p class='util--hide'>View <a href='https://learn.co/lessons/redux-dispatch-with-event-listeners'>Redux Dispatch With Event Listeners</a> on Learn.co and start learning to code for free.</p>
