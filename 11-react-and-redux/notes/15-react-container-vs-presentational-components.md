# React Container Components

In this lesson, we will learn about React "container components." By the end of
this lesson you will be able to:

1. Explain the difference between container components and presentational components
2. Explain how to create a container component.
3. Explain the benefits of using a container component.

## What Are Container Components

We know now that much of our app ought to consist of presentational components, which deal exclusively with the way the UI looks and which preferably carry no state. By the same token, our applications will almost always need some components that take responsibility for the *the way things work.* 


So what is a container component? The main thing to keep in mind here is that container components and presentational components go together. In fact, you can think of them as part of the same design pattern. Where presentational components don't manage state, container components do. Where presentation components are usually subordinate "children" in a component hierarchy, container components are in almost every case the "parents" of presentational components.

Here's a concise definition of the container component pattern:
* Container components are primarily concerned with *how things work*;
* they rarely have any HTML markup of their own, aside from a wrapping `<div>`;
* they are often stateful; and,
* they are responsible for providing data and behavior to their children (usually presentational components).

## An Example

To make things a bit clearer, let's look at an example. Let's take a very basic use case of a `BookList` widget that we need to write for an application that allows book lovers to communicate about their favorite reads. The component specification is simple enough: the component should just render the current user's book list. Here's one way this component could be written:

```javascript
class BookList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      books: []
    };
  }

  componentDidMount() {
    fetch('/api/current_user/book_list')
      .then(response => response.json())
      .then((books => this.setState({ books }));
  }

  render() {
    return (
      <div className="book-list">
        {this.state.books.map(book => {
          <div className="book">
            <img src={book.img_url} />
            <h3>{book.title}</h3>
          </div>
        })}
      </div>
  }
}
```

In some respects, this is a perfectly acceptable component. It meets our basic specification. However, there are some disadvantages to this implementation. Consider for a moment the number of assumptions this component makes about how and what data is fetched and how that data displayed: 
* It assumes that the book list being displayed is related to the current user.
* It assumes that the call to the api returns a JSON object containing a list of book objects with the properties `img_url` and `title`.
* It assumes that the book list will always be rendered with the same markup returned by the render function.

In short, this component has tightly coupled together a whole set of assumptions about the data layer with another set of assumptions about the presentation layer. This is less than ideal.

Why? Well, what if the data returned by our API call changed at some point in the future? Suddenly we'd have errors. Or, what if we found that we needed book lists elsewhere in our app? Could we reuse this code? No! Because the whole thing has too many assumptions built-in; it's just too opinionated about how it should be used. What a shame!


## Separating Concerns using a Container Component

Luckily, with React, we have an alternative. The key lies in our ability to _compose_ our UI out of multiple React components. Using this feature, we can break the above single component into two components. First, we'd isolate the  UI layer into a presentational component; then we'd wrap that presentational component in a container component that handles the state and other business logic.

Here's how this might look. Take a gander:
```javascript
const Book = ({ title, img_url }) => {
  return (
    <div className="book">
      <img src={img_url} />
      <h3>{title}</h3>
    </div>
  )
}

const BookList = ({ books }) => (
  <div className="book-list">
    {books.map(book => <Book title="book.title" img_url="book.image_url" />)}
  </div>
);

class BookListContainer extends React.Component {
  constructor() {
    super();

    this.state = {
      books: []
    };
  }

  componentDidMount() {
    fetch('/api/current_user/book_list')
      .then(response => response.json())
      .then((books => this.setState({ books }));
  }

  render() {
    return <BookList books={this.state.books} />
  }
}
```

So what have we done? We've broken up the original component into a few pieces. All the state is contained in our container component `BookListContainer`. The logic is the same, but it is has been _uncoupled_ from the presentation layer, which is now contained in the `BookList` component. That component, which is stateless, is now incredibly stable as well as concise, especially because we've pulled the rendering logic out and placed it in a discrete function `Book`.

Because we've uncoupled (or to be more precise, loosely coupled) the data and presentation layers, we can now easily reuse the `BookList` component. We could, for example, write another container component &mdash; let's say `FavoritedBookListContainer` &mdash; and then import and wrap `BookList`, in order to build a different piece of our UI with the same code. If, later, our design team decided to redesign the way book lists appear in our app, they would only need to update `BookList`. This is React at its best. Saving time and minimizing codebase. 

We've gained another advantage as well. Because the `BookList` takes a prop `books`, we can add `propTypes` to the component so that we'll receive an informative warning should the structure of the data returned by the API change. Doing that would be as easy as adding this:

```
BookList.propTypes = {
  books: PropTypes.shape({
    img_url: PropTypes.string.isRequired,
    title: PropTypes.string.isRequired
  });
}
```
The container component pattern in React therefore helps us write better code by enhancing the separation of concerns, i.e. the decoupling of the data and presentation layers, and by enabling code-reuse. 

## Resources

- [Container Components](https://medium.com/@learnreact/container-components-c0e67432e005#.2kd1wuyp4)
- [CSS Tricks: Container Components](https://css-tricks.com/learning-react-container-components/)

