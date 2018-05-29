import React, { Component } from 'react';
import ReviewInput from '../reviews/ReviewInput';
import Reviews from '../reviews/Reviews';

export default class Restaurant extends Component {

  onClickHandler(){
    this.props.store.dispatch({
      type: 'DELETE_RESTAURANT',
      id: this.props.restaurant.id
    });
  }

  render() {
    return (
      <li>
        { this.props.restaurant.text }
        <button onClick={ this.onClickHandler.bind(this) }>Delete</button>
        <ReviewInput 
          store={ this.props.store }
          restaurantId={ this.props.restaurant.id } />
      </li>
    );
  }
};

