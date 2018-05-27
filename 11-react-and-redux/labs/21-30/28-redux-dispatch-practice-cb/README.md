# Pet Dispatcher Lab

![so many pets](https://media.giphy.com/media/l0O9xT6oNQfyjjF16/giphy.gif)

## Objectives
1. Write a reducer that can return a default state
2. Construct a `dispatch` function that is invoked with an action, stores the updated state, and renders the new state to the DOM
3.  Write a `render` function that uses vanilla JS to display pet information from the state on a web page

## Overview
Ever have that feeling where you are just surrounded by so many of your pets that you start to lose track of all of them.  Well now there's an app for that-- or there will be-- you're going to build it!  By dispatching actions such as `"ADD_PET"` and `"REMOVE_PET"` to your reducer, you will track your current pets and display them in a beautiful `<ul>` in the browser.

## Instructions
In `managePets.js` you need to write three functions `managePets`, `dispatch`, and `render`.
1. The `managePets` reducer function needs to have a sensible default state
2. `dispatch` should pass an action to the reducer and use that return value to update the state, a globally accessible variable
3. Since our users want to see their pets on a webpage we want to have a `render` method that inserts a `<ul>` to the DOM with each pet's name wrapped in an `<li>`.  The `<ul>` should be a child of an element with the id of `container`. There's no need to load jQuery into our app for such a small task. We can make use of built-in JavaScript methods like `document.getElementById`.
