### Summary

When we last left off, we successfully used our __createStore()__ method, and integrated the method into our __React__ application to update our state. Unfortunately, our __React__ application did not re-render in response to changes in the state. In this lesson, we'll fix that.

## Use the Provider component from React Redux

The reason why the application did not re-render previously is because our __React__ and __Redux__ libraries could not properly communicate to each other correctly to specify that a change in the store's state occurred. Luckily, we can use the __React Redux__ library to get React and Redux talking to one another. Run `npm install react-redux --save` to install it and add to our `package.json`.

The __React Redux__ library gives access to a component called the __Provider__. The __Provider__ is a component that comes from our __React Redux__ library. It wraps around our __App__ component. It does two things for us. The first is that it will alert our __Redux__ app when there has been a change in state, and this will re-render our __React__ app. Let's give it a shot.

Let's add the following code to our `src/index.js` file:

```javascript
// ./src/index.js

import React from 'react';
import ReactDOM from 'react-dom';
import { createStore } from 'redux';
import { Provider } from 'react-redux'; /* code change */
import shoppingListItemReducer from './reducers/shoppingListItemReducer';
import App from './App';
import './index.css';

const store = createStore(
  shoppingListItemReducer,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);

ReactDOM.render(
  <Provider store={store}>
    <App store={store}/>
  </Provider>, /* code change */
  document.getElementById('root')
);
```

We just did a few things here:

* We imported `Provider` from React Redux
* We used `Provider` to wrap our React application
* We passed our store instance into `Provider` as a prop, making it available to all of our other components.

### Step 2: Connecting The Container Component to Store

Using the `<Provider>` component provided by the __React Redux__ library, we gave our components *the ability to be connected to the store*. However, we don't want every component re-rendering in response to every change in the state. So the __React Redux__ library requires us to specify which changes to the store's state should prompt a re-render of the application. We will specify this with the __connect()__ function.

#### Using the `connect()` function

For a component to be connected to the store, i.e. to be able to get data from the store's internal state and to be told to re-render and get new data when that state changes, we will use the __connect()__ function made available to us by React Redux.

Here's how it works:

Open up `./src/App.js` and add the following:

```javascript
// ./src/App.js 

import React, { Component } from 'react';
import { connect } from 'react-redux'; /* code change */
import './App.css';

class App extends Component {

  handleOnClick() {
    this.props.store.dispatch({
      type: 'INCREASE_COUNT',
    });
  }

  render() {
    return (
      <div className="App">
        <button onClick={() => this.handleOnClick()}>
          Click
        </button>
        <p>{this.props.items.length}</p>
      </div>
    );
  }
};

// start of code change
const mapStateToProps = (state) => { 
  return { items: state.items };
};

export default connect(mapStateToProps)(App);
// end of code change
```

Holy cow those last few lines are confusing. Let's see if we can understand them. Remember, that we have two goals here: (a) to only re-render our __App__ component when specific changes to the state occur, and (b) to only provide the slice of the state that we need to our __App__ component. So we will need (1) a function that listens to every change in the store and then (2) filters out the changes relevant to a particular component to (3) provide to that component. That's exactly what's happening here. In the next paragraph, let's go through what is doing what.

```javascript
export default connect(mapStateToProps)(App);
```

The connect function is taking care of task 1, it is synced up to our store, listening to each change in the state that occurs. When a change occurs, it calls a function *that we write* called __mapStateToProps()__, and in __mapStateToProps()__ we specify exactly which slice of the state we want to provide to our component. Here, we want to provide `state.items`, and allow our component to have access to them through a prop called items. So that completes task 2. Then we have to say which component in our application we are providing this data to: you can see that we write `connect(mapStateToProps)(App)` to specify that we are connecting this state to the __App__ component.  
Finally this entire __connect()__ method returns a new component, it looks like the __App__ component we wrote, but now it also receives the correct data. This is the component we wish to export. So at the bottom of the file, you see:

```javascript
const mapStateToProps = (state) => { 
  return { items: state.items };
};

export default connect(mapStateToProps)(App);
```

Note: We didn't have to import anything to define a __mapStateToProps()__ function! We wrote that function ourselves.

Finally, in our __mapStateToProps()__ function we are saying that we are providing a new prop called items, so in our __App__ component, that is the prop we want to reference. 

Ok, __mapStateToProps()__ and __connect()__ is very confusing, so we'll go dig through it some more.  But for now, let's boot up our application, click the button, and see if we can finally get our application to render. Ok, it works - our component now properly re-renders!

###Summary

We learned of two new pieces of __React Redux__ middleware: __connect()__ and __Provider__.  The two pieces work hand in hand. __Provider__ ensures that our entire React application can potentially access data from the store. Then __connect()__, allows us to specify which data we are listening to (through mapStateToProps), and which component we are providing the data. So when you see lines like this:

```javascript
const mapStateToProps = (state) => { 
  return { items: state.items };
};

connect(mapStateToProps)(App);
```

That is saying connect the data in __mapStateToProps()__ (the items portion of the state) to the __App__ component. And the __App__ component can access that state with as this.props.items. Don't fret if you still feel hazy on __connect()__ and __mapStateToProps()__. This is a new middleware api that takes time to learn. We won't introduce any new material in the next code along, we'll just try to deepen our understanding of the material covered in this section. First, please take at least a 15 minute break before moving on.  

