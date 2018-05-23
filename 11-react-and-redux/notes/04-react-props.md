# React props

## Overview

We'll cover props and show how they help us make our components more dynamic and reusable. 

## Objectives
1. Explain how props make our components more dynamic and reusable
2. Pass props to a component by adding them as attributes when you render them
2. Declare default prop values in React
3. Render a component with props and default props


## What are props?
Props allow us to pass values into our components. These values can be anything: a string, an array, functions, and so on. They give us the opportunity to make our components more dynamic, and a **lot more** reusable. For example, say we have a `<MovieCard />` component. A movie has a title, a poster image, and many other attributes (or **prop**erties!). Our component would kind of look like this, with _hardcoded_ data:

```jsx
import React from 'react';
import ReactDOM from 'react-dom';

class MovieCard extends React.Component {
  render() {
    return (
      <div className="movie-card">
        <img src="http://image.tmdb.org/t/p/w342/kqjL17yufvn9OVLyXYpvtyrFfak.jpg" alt="Mad Max: Fury Road" />
        <h2>Mad Max: Fury Road</h2>
        <small>Genres: Action, Adventure, Science Fiction, Thriller</small>
      </div>
    );
  }
}

ReactDOM.render(
  <MovieCard />,
  document.getElementById('root')
);
```

## Passing in props
Mad Max: Fury Road is a ridiculously good movie, but what if we want to render a movie card for another movie? Do we just write another component? No, that would be silly! Instead, we can pass in props to our component to make it dynamic.

To pass props to a component, you add them as attributes when you render them:

```jsx
<MyComponent propName={propValue} />
```

The value of a prop is passed in through curly braces, like above. As we saw before, this value can be anything: a variable, inline values, functions, ... If your value is a hardcoded string, you can pass it in through double quotes instead:

```jsx
<MyComponent propName="propValue" />
```

Armed with that knowledge, let's update our `ReactDOM.render()` call to include the data for the Mad Max movie in our props:

```jsx
ReactDOM.render(
  <MovieCard title="Mad Max: Fury Road" poster="http://image.tmdb.org/t/p/w342/kqjL17yufvn9OVLyXYpvtyrFfak.jpg" genres={['Action', 'Adventure', 'Science Fiction', 'Thriller']} />,
  document.getElementById('root')
);
```

There's a small code style issue at play here: our line with the `MovieCard` component is super long, resulting in code that is pretty hard to read. Thankfully, we can add line breaks to make things more readable again:

```jsx
ReactDOM.render(
  <MovieCard 
    title="Mad Max: Fury Road"
    poster="http://image.tmdb.org/t/p/w342/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
    genres={['Action', 'Adventure', 'Science Fiction', 'Thriller']}
  />,
  document.getElementById('root')
);
```

Notice how we passed in the genres as an inline array? We could also pass in variables instead, like this:

```jsx
const madMaxGenres = ['Action', 'Adventure', 'Science Fiction', 'Thriller'];

ReactDOM.render(
  <MovieCard 
    title="Mad Max: Fury Road"
    poster="http://image.tmdb.org/t/p/w342/kqjL17yufvn9OVLyXYpvtyrFfak.jpg"
    genres={madMaxGenres}
  />,
  document.getElementById('root')
);
```

This would also work for the `title` and `poster` props, but you get the idea.

## Accessing props
Now that we've passed in our props, let's change our hardcoded data in the `render()` method to make use of the props we pass in instead. Props in a component can be accessed through `this.props` in the `render()` method (and most other component methods):

```jsx
class MovieCard extends React.Component {
  render() {
    return (
      <div className="movie-card">
        <img  
          src={this.props.poster} 
          alt={this.props.title} 
        />
        <h2>{this.props.title}</h2>
        <small>Genres: {this.props.genres.join(', ')}</small>
      </div>
    );
  }
}
```

And that's all there is to it! To illustrate, let's render a movie card for Jurassic World:

```jsx
const jurassicWorldGenres = ['Action', 'Adventure', 'Science Fiction', 'Thriller'];

ReactDOM.render(
  <MovieCard
    title="Jurassic World"
    poster="http://image.tmdb.org/t/p/w342/jjBgi2r5cRt36xF6iNUEhzscEcb.jpg"
    genres={jurassicWorldGenres} 
  />,
  document.getElementById('root')
);
```

Woohoo! We've created our first dynamic component. Good job!

## Default values for props
What if we didn't have a poster image for a movie? Ideally, we'd have a default poster image for that instead. Instead of passing in that default poster image in case we don't have one, we can tell our `MovieCard` component to use a default value instead, if the `poster` prop was not provided. To do that, we add the `defaultProps` property to our `MovieCard` class:

```jsx
class MovieCard extends React.Component {
  render() {
    // ... The render stuff from before
  }
}

MovieCard.defaultProps = {
  poster: 'http://i.imgur.com/bJw8ndW.png'
};

const jurassicWorldGenres = ['Action', 'Adventure', 'Science Fiction', 'Thriller'];

ReactDOM.render(
  <MovieCard
    title="Jurassic World"
    genres={jurassicWorldGenres} 
  />,
  document.getElementById('root')
);
```

Now, whenever we omit the `poster` prop, or if it's undefined, the `MovieCard` component will use this default prop instead. That means we don't have to worry about not passing in a poster all the time — the component will take care of this for us!

## Resources
- [React Default Prop Values](https://facebook.github.io/react/docs/reusable-components.html#default-prop-values)
- [Babel: transform-class-properties](http://babeljs.io/docs/plugins/transform-class-properties/)

