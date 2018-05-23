# React Initial State Lab

## Overview
In this lab, you'll set initial state in a React component and distinguish between state and props.

## Image slider
Let's pretend we're making an awesome slider for our new portfolio site. Naturally, we'll use React to do so! We have to start somewhere, so in this lab we'll just focus on setting up the initial state of the slider.

1. In the `components/ImageSlider.js` file, create an `ImageSlider` React component.
2. Its initial state should have a property called `currentSlideIndex` that starts at `0`.
3. It should only render out the text `'I am on slide <CURRENT_SLIDE>'`, where `<CURRENT_SLIDE>` is the value of `this.state.currentSlideIndex`.

## A bomb timer
Take a moment to think about what a bomb does and how it works. Don't get all into the nitty gritty — what we're going to focus on right now is the _timer_. Let's create a component that represents a bomb timer that counts down until it reaches `0`. However, the only thing we're going to focus on right now is setting the initial state of the bomb: the amount of seconds left on the timer. Since bomb timers can differ, we'll pass in a prop to our `Bomb` component to determine what the starting count should be.

1. In the `components/Bomb.js` file, create a `Bomb` React component.
2. Its initial state should have a property called `secondsLeft`.
3. The initial value of `secondsLeft` is set by passing in an `initialCount` prop to the `Bomb` component. Don't forget to pass the argument props into the constructor (i.e., `constructor(props)`).
3. It should render the text `'<SECONDS_LEFT> seconds left before I go boom!'`, where `<SECONDS_LEFT>` is the value of `secondsLeft`.
4. **If `secondsLeft` equals `0`, it should render `'Boom!'` instead.**

## Resources
- [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html)
