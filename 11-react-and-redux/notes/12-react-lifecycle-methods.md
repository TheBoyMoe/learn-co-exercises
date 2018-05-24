# React Component Lifecycle

## Overview 

In this lesson, we'll describe the phases, as well as the importance, of the React component lifecycle. 

## Objectives

1. Distinguish between props and states as they relate to React components 
2. Describe the three phases of the React component lifecycle
3. Define lifecycle methods and how they enable the component to react to different events
4. Define and describe various lifecycle methods

## Component Lifecycle

React components have two sets of properties: **props** and **state**. Props are given to the component by its parent. You can think of props as an external influence that the component has no control over, whereas a component's state is internal to the component. A component's state can change in conjunction to the props changing or when the user interacts with the component.

The React framework was designed to enable developers to create complex and highly reactive UIs. This enables the components to quickly adapt to changes from user interactions or updates in the app. In order to enable this, React components go through what we call a **component lifecycle**. This is broadly divided into three parts: **creation**, **updating**, and **deletion**.

This means that every single thing you see in applications written in React is actually a React component and/or a part of one! For example, if you open a new chat window in a website written in React, a `ChatWindow` component is **created**. As you are interacting with it and sending messages to your friends - that's the **updating** part. And when you finally close the window, the React component gets **deleted**.

It seems all pretty straightforward from the user's perspective, however as you'll soon find out, there's a lot of stuff going on behind the scenes.

## Lifecycle hooks and rendering
In order to enable this quick reacting and updating, as a developer, you get access to certain built-in events in the  React component lifecycle called **lifecycle hooks** or **lifecycle methods**. These are opportunities for you to change how the component reacts (or doesn't react) to various changes in your app.

These methods are called *lifecycle* methods, because they are called at different times in the component's lifecycle - just before it's created, after it's created, and when it's about to be deleted.

The only required method for a React component to be valid is the `render()` method which describes what the HTML for the component looks like. There are a whole host of optional methods you can use if you need more control over how the component responds to change.

## Pre-mounting
It is important to remember that components, at their core, are just JS classes. This means that even before mounting has begun, the class's `constructor` function is called. 

While the `constructor` is not related to mounting to the DOM, it is the first function called upon the initialization of a component; this makes it useful for creating an initial state for a component.

## Mounting
When the component is initially created, it gets mounted onto the DOM. It sounds more complicated than it is: the component figures out its initial state and renders its initial JSX onto the page. At the mounting stage, there are two *lifecycle hooks* available to us: `componentWillMount`, and `componentDidMount`. 

After the `constructor` is called, `componentWillMount` will get called just _before_ `render`. There is not much use for this hook - even [the React documentation](https://reactjs.org/docs/react-component.html#componentwillmount) mentions that anything you could do here is better done in either `constructor` or `componentDidMount`.

`componentDidMount` will get called just _after_ the `render` method. You would use this method to set up any long-running processes or asynchronous processes such as fetching and updating data.

## Updating
Whenever a component's state or props are changed, it gets re-rendered on the page. That's the beauty of React components - they're quick to *react* to changes. A re-render could be triggered when a user interacts with the component, or if new data (props or state) is passed in.

For example, going back to the chat window example, whenever you press "send" on a message, the `ChatWindow` component gets re-rendered as it needs to display an extra message. Whenever a re-render is triggered, there is a whole host of lifecycle hooks that get called. You can choose to use any of these to decide how your React component should respond to changes.

`componentWillReceiveProps` is invoked when the props the parent is passing into the component have changed. You could use this to change the component's state based on the new props.

`shouldComponentUpdate` is invoked just before the component is about to re-render. At this stage, you can compare the old and new props and state and prevent unnecessary re-renders: if the changes in state and/or props don't actually alter the component that's being shown to the user, there is no point "repainting" it as it is an unnecessary performance drain.

`componentWillUpdate` is called just after `shouldComponentUpdate` has finished and just before the new component gets rendered. You would usually use this method to update integrations with third party libraries.

`componentDidUpdate` is called just after the new component had been rendered. You will have access to the previous props and state as well as the current ones, and you can use this method to update any third party libraries if they happen to need an update due to the re-render.

## Unmounting
At the unmounting stage, the component gets deleted and cleared out of the page. The only lifecycle hook at this stage is `componentWillUnmount`, which is called just before the component gets deleted. This is used to clear out any stuff set up in `componentDidMount`.

For example, if you had a component that displays the weather data in your home town, you might have set it up to re-fetch the updated weather information every 10 seconds in `componentDidMount`. When the component gets deleted, you wouldn't want to continue doing this data-fetching, so you'd have to get rid of what was set up in `componentWillUnmount`.

## Summary
Imagine a big old oak tree. The tree could be a parent component, each of its branches a child component of the tree, each of its leaves a child component of the branch and so on. Each of the leaves go through a very obvious lifecycle of being created, changing based on state (changing colour based on the season, withering if there's not enough nutrition being passed down from the parent branch, changing into a leaf with a hole bitten out of it if a caterpillar munches on it), and finally falling down when it's autumn.

So as it seems, if you need a lifecycle hook, there's sure to be one for your every need!

### Mounting lifecycle methods
Called once on initial render:

| Method             | nextProps | nextState | Can call `this.setState` | Called when?               | Used for                                                                                    |
|:-------------------------:|:---------:|:---------:|:----------------------:|:-------------------------------------------------------:|:--------------------------------------------------------------------------------:|
| `constructor` |     no    |     no    |           no          | once, just before `componentWillMount` is called | Setting initial state                                             |
| `componentWillMount` |     no    |     no    |           yes          | once, just before mounting | Not commonly used                                              |
| `componentDidMount`  |     no    |     no    |           yes           | once, just after mounting  | setting up side effects (e.g. creating new DOM elements or setting up asynchronous functions |


### Updating lifecycle methods
Not called on initial render, but always called whenever a subsequent re-render is triggered:

|           Method          | nextProps | nextState | Can call `this.setState` |                       Called when?                      |                                     Used for                                     |
|:-------------------------:|:---------:|:---------:|:----------------------:|:-------------------------------------------------------:|:--------------------------------------------------------------------------------:|
| `componentWillReceiveProps` |    yes    |     no    |           yes          |  many times, whenever component is going to receive new props  |                     applying state changes based on new props                    |
|   `shouldComponentUpdate`   |    yes    |    yes    |           no           |    many times, whenever a re-render has been triggered    |    deciding based on new & old props & state whether a re-render should occur    |
|    `componentWillUpdate`    |    yes    |    yes    |           no           | many times, when new state and props are being received | prepare for the update, dispatch any actions or animations based on state change |
|     `componentDidUpdate`    |    yes*   |    yes*   |           yes          |    many times, just after the re-render has finished    | any DOM updates following a render (mostly interacting with 3rd party libraries) |

\* `componentDidUpdate` will actually receive `prevProps` and `prevState` as arguments, as the newly applied state and props can be accessed through `this.props` and `this.state`.


### Dismounting lifecycle method
Called only once, just before the component is removed from the DOM:

|        Method        | nextProps | nextState | Can call `this.setState` |                     Called when?                    |                         Used for                        |
|:--------------------:|:---------:|:---------:|:----------------------:|:---------------------------------------------------:|:-------------------------------------------------------:|
| `componentWillUnmount` |     no    |     no    |           no           | once, just before component is removed from the DOM | destroying any side effects set up in componentDidMount |



## Resources

- [React: Component Specs and Lifecycle](https://facebook.github.io/react/docs/component-specs.html)
- [Understanding the React Component Lifecycle](http://busypeoples.github.io/post/react-component-lifecycle/)

