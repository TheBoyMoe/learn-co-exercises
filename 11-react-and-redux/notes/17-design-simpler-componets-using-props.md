# Props Props Props Props Props Props

In this lesson, we will learn more about the important role that `props` play
in React applications. By the end of the lesson you will be able to:

1. Explain the role that props play in a React application
2. Explain why props are preferable to state
3. Explain how we can design components with minimal complexity using props

## Props are good because state is...

...bad? Actually, no. It's not that state is bad. In fact, using state in our React components is often necessary, and the ability to explicitly and reliably update state in our components is one of the most powerful features of React. But, state creates complexity.

Once a component has state, it becomes harder to predict its output and behavior. Because state changes, we won't be able to say at any given point in our program's operation what state our component is in. That, in turn, will make it harder to reason about our application; and when it becomes harder to reason about our application we will struggle more to eradicate and avoid bugs.

> Note: A general principle that one can take on here, as an arguable truth about application design, is that while we often find ourselves needing state in our applications, it is state that our human brains struggle most to parse and track.

So, if state is something we should avoid, what are some strategies to achieve that goal? This is where `props` come in!

Props provide us with a way to minimize the number of components in our app that need to carry and manage state. Another, more evocative, way to say this is that `props` provide us with a method for reducing the total "surface area" of our app that is stateful. The reason `props` help us to minimize `state` is because we can use them to send data _down_ into our nested child components. Because we can send data _down_, we can _push state up_, thereby concentrating state at the "top" of our UI's hierarchy. 

This may all seem a bit abstract at this point, so let's take a look at an example to illustrate our point.

## A use-case for pushing state upwards 

Imagine we have an app, a Fruit Basket app. It's simple. It just tracks what's
in our fruit basket, and what's already been eaten. In designing our application,
let's say that we initially decide to build two components -- `FruitNotEaten` and
`FruitEaten` -- each of which is responsible for fetching its own list
from the app's backend.

Given this plan, our `FruitEaten` component, for example, could look like this:

```javascript
class FruitEaten extends Component {
  constructor(props) {
    super(props);

    this.state = { 
      fruitList: []
    };
  }

  componentDidMount() {
    // Assume that this fetch function is a Promise that
    // can go over the internet.
    fetch('/api/fruit?eaten=true')
      .then(response => response.json())
      .then(fruitList => this.setState({ fruitList }));
  }

  render() {
    return (
      <ul>
        {this.state.fruitList.map(fruit => <li key={fruit}>{fruit}</li>)}
      </ul>
    );
  }
}
```

What we have here is a component that fetches a list of already eaten fruit and then renders that to a list. So what's the problem? Looks fine, right?

Well...in this simple case everything looks good. But remember, we've only implemented one of our components. The `FruitNotEaten` component will also have to be able to fetch and update its state. Already, we can see that we're starting to repeat ourselves unnecessarily. The fetching process for fruit isn't really all that different in  each component. So why do we need to implement it twice? Plus, in general, we know that we should minimize state as much as possible to avoid bugs, and yet here we have two components maintaining their own state. That's a lot of state in such a small app!

## How to minimize state with `props`

So what can we do to minimize state? Well, let's think. Our two components are both lists; they aren't really all that different. What if we just think of our two components as one simple "presentational" component called `FruitList`? This component will just know how to render a list of fruits. And where will it get this list? That's right...it will receive the list as a `prop`. So our new `FruitList` component can even be implemented as a stateless functional component:

```js
const FruitList = props =>
  <ul>
    {props.fruitList.map((fruit) => {
      return <li key={fruit}>{fruit}</li>;
    })}
  </ul>;
```

Beautiful, right?! So much simpler and more stable. But what about our state? How
will this newly simplified `FruitList` know which fruits to display? Well, all that
can now be handled at the top of our simple application, by the `FruitList`'s
parent. Let's say, to keep our example very simple, `FruitList` is embedded in a
top-level component `App`. `App` could be implemented something like this:

```javascript
class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      showEaten: false,
      fruits: []
    };
  }

  componentDidMount() {
    this.updateFruitList();
  }

  toggleListMode = () => this.setState({ showEaten: !this.state.showEaten });

  updateFruitList = () => {
    fetch(`/api/fruit?eaten=${this.state.showEaten}`)
      .then(response => response.json())
      .then(fruits => this.setState({ fruits }));
  }

  render() {
    render <FruitList fruitList={this.state.fruits} />;
  }
}
```
So what have we done here? Well, there's a bunch of code here, but really all we've done is setup the same mechanism to fetch a list of fruit from the backend. We necessarily had to add a bit more logic to switch the application's "mode" so that the `App` component fetches the appropriate list, but then all we had to do is send that list down into our `FruitList` component to be rendered.

Now this might seem as though it's a bit more involved, but think of what we've accomplished here! Let's summarize. By using props to send our fruit list data downward, we've been able to simplify our application's implementation, reducing two components into one. Already that's a huge reduction in code. But that's not all we've done.

We've also been able to remove all that complex state logic, once maintained in  our `FruitsEaten` and `FruitsNotEaten` components, by _pushing it up the component hierarchy_. Because our newly simplified `FruitList` component just receives the list of fruits it should display from its parent component, its parent component `App` is the only one that needs to be "smart". So not only have we reduced our code base, we've also centralized  our business logic, which will make it much easier to modify and maintain going forward. This is a huge gain -- all thanks to the power of `props`.

Mad props to props!

## Resources

- [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html)
- [Props vs. State](https://github.com/uberVU/react-guide/blob/master/props-vs-state.md)

