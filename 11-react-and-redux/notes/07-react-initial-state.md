# React Initial State

## Overview 

In this lesson, we'll explain the concept of component state. 

## Objectives
1. Explain how to define a component's initial state
2. Explain the difference between initialState and defaultProps
3. Practice defining a component's initial state

## What's state?
Let's quickly talk about what _state_ is in React. State is basically data that is mutated in your component. Like with any state, this state can also **change**. That's an important part: while a component can't change its own props, it _can_ change its state.

State is used to handle several things in your component:

- Interactivity (e.g. changing data when a user clicks a button)
- Fetching remote data (remote data is, by definition, not available right away when the component is mounted — state gives us a way of updating the component once that data arrives)
- Reacting to the passing of time (i.e. setting an interval or timeout)

## Props vs state
As mentioned before, it's important to know the difference between props and state. Props and state are used as input for the `render()` method to determine its output, but they are _not_ the same thing! The best way to figure out if data should go in props or state is to ask ourselves _'Will this data ever change?'_. If not, it's a prop. If it will, it should go in state! Keep in mind that whenever props _and/or_ state change, the component will run its `render()` method again.

## Setting initial state

Enough talk, let's see some more code! In this lesson, we'll focus on just setting the _initial state_. Since we're just setting the initial state, it will remind you very much of props (since the data won't change). Keep in mind, though, that we're able to _change_ this state whenever we want, making for a very powerful feature for dynamic components.

You can follow along by running `npm install && npm start` in your terminal. The starter code to mount the React app is in `/src/index.js`. The component files are already prepped for you to add the code in this lesson.

Let's say we have a `<ToggleButton />` component. A toggle button has an on and off state. Using props for that value wouldn't work, since we can't actually change our props! Let's use state for this instead. We'll assume that the default state of this component is to be in the _off_ state. Let's call that state property `isEnabled`. Setting the initial state is done in the `constructor` of our React Component:

```js
// src/components/ToggleButton.js
import React from 'react';

class ToggleButton extends React.Component { 
  constructor() {
    super();

    this.state = {
      isEnabled: false
    }
  }

  render() {
    return (
      <button className="toggle-button">
        I am toggled {this.state.isEnabled ? 'on' : 'off'}
      </button>
    )
  }
}

export default ToggleButton;
```

and in our `src/index.js` lets import that to see what it looks like 

```js 
// src/index.js
import React from 'react';
import ReactDOM from 'react-dom';

import ToggleButton from './components/ToggleButton';

ReactDOM.render(
  <ToggleButton />,
  document.getElementById('root')
);
```

In the browser, our component should currently show 'I am toggled off.' on the screen, since the initial state has set the `isEnabled` property to `false`. Not very exciting yet, but we'll get there!

## Minimal representation of state
It's important to try and keep your state **as small as possible**. You should strive for a minimal amount of data in your state and compute the rest. For example, let's make an Address component `<Address />` that takes in two props: the `street` and the `city`. We'll add those two together to show the user a complete address. An example of having computed data in your state would be this:

```js
// src/components/Address.js
import React from 'react';

class Address extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      fullAddress: `${props.street}, ${props.city}`
    }
  } 

  render() {
    return (
      <div className="address">
        {this.state.fullAddress}
      </div>
    );
  }
}

export default Address;
```

And we should update our `src/index.js` to handle mounting this component:

```js 
// src/index.js
import React from 'react';
import ReactDOM from 'react-dom';

import Address from './components/Address';

ReactDOM.render(
  <Address 
    street="Santa Monica Blvd."
    city="Santa Monica"
  />,
  document.getElementById('root')
);
```

While this is all perfectly valid React code, storing computed values in your state (in this case, `fullAddress`) should be avoided. There's no good reason for the full address to go into our state, since we're just using props to 'compute' the full address. Instead, we should use the component's props directly:


```js
class Address extends React.Component {
  render() {
    return (
      <div className="address">{this.props.street}, {this.props.city}</div>
    );
  }
}
```

## Conclusion
While component state is a very powerful feature, it should be used as sparingly as possible. State is hard to manage and can be very easy to lose sight of. The more state we introduce in our application, the harder it will be to keep track of all of the changes in our data. We've only defined the initial state here — it's not very exciting, but it's a start!

## Resources
- [Official React docs on state](https://facebook.github.io/react/docs/interactivity-and-dynamic-uis.html#components-are-just-state-machines)
- [Props vs. state](https://github.com/uberVU/react-guide/blob/master/props-vs-state.md)
- [Props in getInitialState Is an Anti-Pattern](https://facebook.github.io/react/tips/props-in-getInitialState-as-anti-pattern.html)

