import React, { Component } from 'react';
import Reviews from './Reviews';

export default class ReviewInput extends Component {
  constructor(props){
    super(props);
    this.state = {
      text: ''
    }
  }

  onChangeHandler(e){
    this.setState({
      text: e.target.value
    });
  }

  onSubmitHandler(e){
    e.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_REVIEW',
      review: {
        text: this.state.text,
        restaurantId: this.props.restaurantId
      }
    });
    this.setState({
      text: ''
    });
  }
  
  render() {
    return (
      <div>
        <form onSubmit={ this.onSubmitHandler.bind(this) }>
          <input
            type="text"
            onChange={ this.onChangeHandler.bind(this) }
            value={ this.state.text }
          />
          <input type="submit" value="Submit" />
        </form>
        <Reviews 
          store={ this.props.store }
          restaurantId={ this.props.restaurantId } 
        />
      </div>
    );
  }
};

