# Component Mounting and Unmounting

## Overview

We'll describe what happens in the mounting and unmounting phases of a React component's lifecycle. 

## Objectives

1. Describe the `componentWillMount` and `componentDidMount` lifecycle methods in the mounting phase
2. Describe the `componentWillUnmount` lifecycle method in the unmounting phase


## Setup and Cleanup 

A React component's lifecycle contains distinct phases for creation and deletion. In coding terms, these are called **mounting** and **unmounting**. You can also think of them as "setup" and "cleanup".

If you were going to have a picnic, just before you lay down the picnic blanket you'd make sure the ground was level and clean. Also, after you're done, and before you clean up your picnic blanket, you'd make sure you've taken all your belongings off it and cleared up any garbage left on the grass so people after you can easily use the same spot.

That's very similar to what happens with React components. The browser window is almost like a great big field that loads the components that can be used. And when they leave, it's only polite of them to clean up the space they were using — so that other components can reuse the same space without any annoyances due to things left behind.

## Pre-Mounting

### `constructor`

Technically the **`constructor`** is the first function called upon instantiating **any** class in JS, not just React Components. That being said, the **`constructor`** has an important role in the life of a component, as it acts as a perfect place to set the initial state of a component. Within the constructor, one can initialize state like so: 

```javascript
constructor() {
  super()
  this.state = {
    key: "value"
  }
}

//Note: In ES7, it is possible to initialize state by simply doing the following inside of your component. If you see either the syntax above or below, keep in mind that they accomplish the same task.

state = {
  key: "value"
}
```
Note: Bear in mind that we call `super` so that we can execute the `constructor` function that is inherited from React.Component while adding our own functionality.

It is possible to use the `constructor` to set an initial state that is dependent upon props like so:
```javascript
constructor(props) {
  super(props);
  this.state = {
    color: props.initialColor
  };
}
//source: https://reactjs.org/docs/react-component.html#constructor
```
Note that in contrast to the previous example, we take `props` as an argument to the constructor. This is because we are making use of the props to set an initial state - if we aren't using props to do this, then we need not include `props` as an argument to the constructor. 

## Mounting

In the mounting (or DOM creation, or "setup") phase, we have access to two  **lifecycle methods**: **`componentWillMount`**, and **`componentDidMount`**.


### `componentWillMount`

**`componentWillMount`** is called only once in the component lifecycle, immediately before the component is rendered. `componentWillMount` is largely considered problematic, and as of now, is being considered for deprecation. If your intention is to set an initial state for your component, it is preferable for you to do this in the `constructor` as shown above. If your intention is to set state using data from an async request, it is preferable that you do this in `componentDidMount`, as we will see below.

In picnic terms, `componentWillMount` is the moment when you arrive at the field with your picnic blanket and you make sure the spot you've chosen is nice and level. You might find some twigs or little rocks you need to clean up before you lay your blanket down.

In React terms, the use-cases for this are quite subtle. For example, suppose you want to keep the time and date of when the component was created in your component state, you could set this up in `componentWillMount`.

```javascript
componentWillMount() {
  this.setState({ startDateTime: new Date(Date.now())});
}
```

### `componentDidMount`

Similarily to the method above, **`componentDidMount`** is also only called once, but immediately *after* the `render()` method has taken place. That means that the HTML for the React component has been rendered into the DOM and can be accessed if necessary. This method is used to perform any DOM manipulation of data-fetching that the component might need.

If you were at a picnic, this is the moment just after you've laid out your blanket. You would use this time to set up any things you want to be using during your stay: lay out all your food and drinks, maybe take out a radio and put some music on.

In React, this is where you would set up any long-running processes you want to use in your component, for example fetching data. Suppose we were building a weather app that fetches data on the current weather and displays it to the user. We would want this data to update every 15 seconds without the user having to refresh the page. `componentDidMount` to the rescue!

```javascript
componentDidMount() {
  this.interval = setInterval(this.fetchWeather, 15000);
}
```

## Unmounting

In the unmounting (or deletion, or "cleanup") phase, we have just one lifecycle method to help us out: `componentWillUnmount`. `componentWillUnmount` is the last function to be called immediately before the component is removed from the DOM. It is generally used to perform clean-up for any DOM-elements or timers created in **`componentWillMount`**.

At a picnic, `componentWillUnmount` corresponds to just before you pick up your picnic blanket. You would need to clean up all the food and drinks you've set on the blanket first or they'd spill everywhere! You'd also have to shut down your radio. After that's all done you would be free to pick up your picnic blanket and put it back in the bag safely.

For a React component, this is where you would clean up any of those long running processes that you set up in `componentDidMount`. In the above data fetching example, all we would have to do is clear the interval so that the weather API would no longer get called every 15 seconds:

```javascript
componentWillUnmount() {
  clearInterval(this.interval);
}
```

## Summary

The mounting and unmounting steps are important for ensuring that the React component gets set up and initialized nicely and that when it gets unmounted, it leaves the space it occupied just as it was before: nice and tidy.

In the mounting step, we can set up any special requirements we may have for that particular component: fetch some data, start counters etc. It is extremely important to clean up all the things we set up in the unmounting stage in `componentWillUnmount`, as not doing so may lead to some pretty nasty consequences - even as bad as crashing your carefully crafted application!

### Mounting lifecycle methods
Called once on initial render:

| Method             | nextProps | nextState | Can call `this.setState` | Called when?               | Used for                                                                                    |
|--------------------|:---------:|:---------:|:----------------------:|:--------------------------:|:-------------------------------------------------------------------------------------------:|
| `constructor` |     no    |     no    |           no          | once, just before `componentWillMount` is called | Setting initial state                                             |
| `componentWillMount` |     no    |     no    |           yes          | once, just before mounting | Not commonly used                                              |
| `componentDidMount`  |     no    |     no    |           yes          | once, just after mounting  | setting up side effects (e.g. creating new DOM elements or setting up asynchronous functions |

### Unmounting lifecycle method
Called only once, just before the component is removed from the DOM:

|        Method        | nextProps | nextState | Can call `this.setState` |                     Called when?                    |                         Used for                        |
|:--------------------:|:---------:|:---------:|:----------------------:|:---------------------------------------------------:|:-------------------------------------------------------:|
| `componentWillUnmount` |     no    |     no    |           no           | once, just before component is removed form the DOM | destroying any side effects set up in `componentDidMount` |

## Resources

- [React: Component Specs and Lifecycle](https://facebook.github.io/react/docs/component-specs.html)

