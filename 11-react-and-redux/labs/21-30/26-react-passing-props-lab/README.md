# React Passing Props Lab

## Overview

In this lab, you'll pass props around and move state to the edge of the application. 

## The Flawed Fruit Basket

![](http://www.animaatjes.de/glitzer-bilder/e/essen-und-trinken/glitzer049.gif)

Fruit baskets are wonderful shimmering examples of the beauty of nature. But they also have a few design flaws. For one, it can sometimes be challenging to choose which fruit you want to eat. So much abundance! Where to start? Also, it can occur that you pick a fruit that is on the top of the fruit bowl, only to discover later that a more desirable fruit lay hidden below.

In this lab, we will work with an app that has solved this age-old problem. Because isn't that what technology is for? The application in question is a newfangled type of fruit basket that is able to filter its contents according to the type of fruit. Because it's futuristic &mdash; and everyone in the future is all science-y &mdash; our app will filter by scientific fruit categories like pome, pepo, and drupe. But the bottom line is that this app will help people get the fruit that they truly want!

![](https://media.giphy.com/media/97ZWlB7ENlalq/giphy.gif)

## The Task at Hand

Now, one thing that is a bit unusual about this lab is that rather than building the app from scratch, we will instead work with an application that has already been built. If you run `npm start`, you should see the product in all its glory.

Although this app is already working, its original implementation frankly leaves something to be desired. The application has too many components that are unnecessarily maintaining state. To drive this point home, take a look at this representation of the application's component hierarchy:

```javascript
<App>
  <FruitBasket>
    <Filter />
    <FilteredFruitList />
  </FruitBasket>
</App>
```

As you can see our application consists of four components. That's fine, but what's shocking is that out of the four components, three are maintaining state! This is both unnecessary and a bad design choice, as state is largely unstable and tends to be buggier. Certainly, we can do better.

This is where we come in. Our task in this lab is to [refactor](https://en.wikipedia.org/wiki/Code_refactoring) this application so that state is maintained only at the top of the application in the `App` component. To do this we'll need to take advantage of what we've learned about the way `props` help us to push state to the edges of our application.

By the end of our refactoring process, the only component that should hold state is the `App`component. It should maintain all state and also handle the fetching of all the necessary data, which it will then pass down into the "dumb" presentational components below for rendering.

## How to Approach This Lab

As this lab is an exercise in refactoring, what you'll need to do is determine the behavior of the lab by reading the code and examining the way the app functions currently. Once you've understood the current structure of the program, your goals are as follows:
* Move all state into the top-level `App` component.
* Use `props` to transfer the necessary data and callback functions down into the component hierarchy.
* Ensure that all the remaining components (`FruitBasket`, `FilteredFruitList`,  and `Filter`) are stateless functional components that are strictly presentational.
* In the process of achieving this refactoring, do not change the UI or the way it functions.

As with other labs, we have provided a set of tests all of which must be passing when you have completed the lab. A few of the tests are passing already because after all the app is already working. Just make sure they continue to pass in your final product.

## Resources

- Richard Feldman, ["React 0.14: Why Local Component State is a Trap"](https://www.safaribooksonline.com/blog/2015/10/29/react-local-component-state/)
- Code Refatoring (Wikipedia): https://en.wikipedia.org/wiki/Code_refactoring

<p class='util--hide'>View <a href='https://learn.co/lessons/react-passing-props-lab'>Passing Props Lab</a> on Learn.co and start learning to code for free.</p>
