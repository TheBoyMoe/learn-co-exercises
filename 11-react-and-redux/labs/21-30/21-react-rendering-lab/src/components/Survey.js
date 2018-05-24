import React from 'react';
import Rating from './Rating';

function random(array) {
  return array[Math.floor(Math.random() * array.length)];
}

class Survey extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      rating: 0
    };
  }

  increaseRating = () => {
    this.setState({ rating: this.state.rating + 1 });
  }

  decreaseRating = () => {
    this.setState({ rating: this.state.rating - 1 });
  }

  maintainRating = () => this.forceUpdate();

  render() {
    return (
      <div>
        <Rating rating={this.state.rating} />
        <button onClick={this.increaseRating}>Loved it!</button>
        <button onClick={this.maintainRating}>Indifferent!</button>
        <button onClick={this.decreaseRating}>Hated it!</button>
      </div>
    )
  }
}

export default Survey;
