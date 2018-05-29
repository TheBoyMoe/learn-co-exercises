import React, { Component } from 'react';
import Restaurant from './Restaurant';

export default class Restaurants extends Component {
  render() {
    const restaurants = this.props.store.getState().restaurants.map((restaurant, i) => {
      return (
        <Restaurant 
          key={i}
          restaurant={ restaurant }
          store={ this.props.store }
        />
      );
    });
    return(
      <ul>
        { restaurants }
      </ul>
    );
  }
};

