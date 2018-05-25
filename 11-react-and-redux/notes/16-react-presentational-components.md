# React Presentation Components

## Overview
In this lesson, we will examine a specific "type" of React component known as a "presentational" component.

## Objectives

1. Explain the benefits of presentational components
2. Describe how we can add interactivity to presentational components by adding a callback function as a prop
3. Explain how to use stateless functional components

# What makes a component "presentational"?

The answer to this question, as you may have guessed, is that a presentational component is a component whose primary responsibility is to render some piece of the beautiful user interfaces that we get to build as web developers. Their job, in other words, is to look good!

There is, however, a bit more thinking that we need to do here, just so we understand precisely what it means when we say that a component is of the type "presentational." Very often when we speak of classes or categories of things in the world of programming, the types or classes that we are discussing are actually formalized in the libraries or languages themselves. Think, for example of when we declare a React `Component.` we write `class SomeComponent extends Component`. Either way, we are creating an actual instance of `Component`.

But here's the rub. When we say that some component is "presentational" *we definitely do not mean* that the component is a formal type or class defined by the React library. There is no such thing as type `PresentationalComponent` in the React library. Rather, what we are dealing with here is simply a useful *convention*, or, better yet, a *programming pattern* that coders who have used React have found themselves following over and over again as they compose their component-based React UIs.

So what defines the presentational component pattern? Here's a list of defining features:
* Presentational components are primarily concerned with how things look;
* they probably only contain a render method;
* they do not know how to load or alter the data that they render;
* they rarely have any internally changeable `state` properties;
* and, they are best written as stateless functional components.

Okay, so there's our pattern description. Now let's jump into some code and see how presentation components actually look in practice.

## Surprise, you've already written presentational components!

Yep, this is true. Think about it. If a presentational component is simply a component that doesn't know anything about how to get the data it displays, and is mainly responsible for presentation, then you've been doing this from the beginning. A simple `HelloWorld` component, for example, is almost certainly presentational. Let's see if that's right &mdash; we'll even give our component the ability to take a prop:

```javascript
class HelloWorld extends Component {
  render() {
    return <div class="hello-world">Hello {this.props.message || 'World' }</div>;
  }
}
```

So does this fit our pattern? Absolutely, it does. Here is a component that does nothing but render a piece of our UI; that has no notion of how to fetch or reload the `message` data that it takes in as a `prop`; that has no changeable state; and that only contains a render method. So, I think we can safely say it fits the pattern well.

## Great, but when would we need such a simple component?

Good question! Our `HelloWorld` example is obviously not a very real-world example, but consider this: let's say we are working on a massive web application, and we'd like to standardize as well as place some limits on the characteristics of the  text inputs used throughout the application's forms.

In this case, we could certainly establish a style guide in our development team that dictates that all uses of `<input>` use a specific set of CSS classes, defined in our stylesheets, but this leaves our app open to a lot of human error. People would have to consistently follow the convention over time. And while we could certainly add props to our inputs by doing something like this -- `<input className='field' {...props}>` -- we've left the types of props that can be provided to our inputs wide open.

With React, we can do much better! Consider this `TextField` component:

```javascript
const defaultLimit = 100

class TextField extends Component {
  render() {
    return (
      <input
        className="field field-light"
        onChange={this.props.onChange}
        maxLength={this.props.limit || defaultLimit} 
      />
    );
  }
}
```

First off, notice that here again, what we have a component that fits the presentational pattern. It's a simple wrapper around an `<input>`. But look how powerful it is! This simple wrapper establishes the CSS classes we will use in one place for every single input used throughout the app. Think of how easy it would be to change if we later decided we wanted a different look! But that's not all we've accomplished here. The component also establishes a straightforward API for all our text fields consisting of an `onChange` callback -- because in most cases our `<input>`s are going to need to perform some action when the users type -- and a `limit` for the amount of characters that a user can enter in the field. So although our presentational component is simple, it can still have a degree of interactivity through the addition of callbacks.

Now, of course, we can argue about whether wrapping the `<input>` field in this way is a good idea. After all, `<input>`s are nice simple implementations in their own right. But providing a component-based interface to text inputs as we have in the field above is potentially a great win for simplicity in our app. It specifically defines what we mean by a text input; it does so in a way that arguably covers the majority of use-cases we can imagine for a simple text input; and it provides this definition in one place that can be found and updated easily in the future. Win, win, win. Are we beginning to see the power of presentational components? Good.

Now imagine that it's not just the `TextField` that our team has executed in this way, but say we've also defined a `<Header />` and a `<Footer />`, as well as other more unique and customized modules that are still primarily presentational. Imagine further that we've composed the majority of our UI out of these simple presentational components -- all of them almost entirely stateless, all of them designed to do one thing and one thing well: they just receive `props` from their parent components and render! That's it. They are simple and beautiful and because they aren't doing much, because they are mostly stateless, they have a better chance of remaining blissfully bug free!

This is the power and importance of presentational components. They are simple and they just work. So therefore we should strive to use them as much as possible.

## The "Stateless Functional" Component & "Pure" Functions

What if I told you we can actually make our presentational components even simpler? Well we can, and here's why: Remember how one of the principles in our checklist for the presentational component pattern was that the component (probably) does not have state? Well, if in fact we can create a component that has no state, that means that our component doesn't even really need to be a JavaScript object of type `Component` at all. It can just be a simple function &mdash; one that takes an input and returns a (portion of) the UI.

So what's this look like? Here's our `TextField` component rendered as a so-called "functional stateless" component (a feature available in React since v0.14):

```javascript
const defaultLimit = 100

const TextField = (props) => 
  <input
    className="field field-light"
    onChange={props.onChange}
    limit={props.limit || defaultLimit} 
  />;
```
Now isn't that just beautiful? It really is. It's just so concise. We've discarded all that ugly boilerplate. But it's not only concision that makes this beautiful. By transforming our component into a stateless function, we have made our `TextField` component an extremely stable and predictable part of our application.

The predictability comes from the fact -- and here we can see the influence of the principles of functional programming on React -- that this function will always return the same UI output if given the same `props`. There are no state variables here that could be set to different values at different times that might lead the function to return something that we didn't predict. What we have here, then, is what in functional terms is called a "pure" or "referentially transparent"  function.  Our UI has become just a bit more predictable. And, as web developers who've worked on the front-end, we know what a boon that is, don't we? (To review pure functions at greater length, see [this lesson](https://github.com/learn-co-curriculum/javascript-pure-functions) on the theme.)

## Resources
- ["Software Design Patterns"](https://en.wikipedia.org/wiki/Software_design_pattern) (Wikipedia)
- Dan Abramov, ["Presentational and Container Components"](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0)
- [Stateless Functions](https://facebook.github.io/react/docs/reusable-components.html#stateless-functions)

