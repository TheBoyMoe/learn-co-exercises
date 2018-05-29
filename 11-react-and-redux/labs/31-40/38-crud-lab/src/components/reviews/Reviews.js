import React, { Component } from 'react';
import Review from './Review';

export default class Reviews extends Component {
  render() {
    let reviews = this.props.store.getState().reviews.filter((review) => review.restaurantId === this.props.restaurantId);
    reviews = reviews.map((review, i) => {
      return (
        <Review
          key={i}
          review={ review }
          store={ this.props.store }
        />
      );
    });
    return (
      <ul>
        { reviews }
      </ul>
    );
  }
};

