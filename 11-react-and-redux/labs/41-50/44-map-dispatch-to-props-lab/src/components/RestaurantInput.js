import React, { Component } from 'react';
import { addRestaurant } from '../actions/restaurants';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

export class RestaurantInput extends Component {

  constructor(props){
    super(props);

    this.state = {
      name: '', location: ''
    };
  }

  handleOnNameChange(event) {
    this.setState({
      name: event.target.value
    });
  }

  handleOnLocationChange(event) {
    this.setState({
      location: event.target.value
    });
  }

  handleOnSubmit(event) {
    event.preventDefault();
    this.props.addRestaurant(this.state);
  }

  render() {
    return(
      <form onSubmit={ this.handleOnSubmit.bind(this)}>
        <p>
          <input 
            type="text" 
            onChange={ this.handleOnNameChange.bind(this)} 
            placeholder="restaurant name" />
        </p>
        <p>
          <input 
            type="text" 
            onChange={ this.handleOnLocationChange.bind(this)} 
            placeholder="location" />
        </p>
        <input type="submit" value="Submit" />
      </form>
    );
  }
};

const mapDispatchToProps = (dispatch) => {
  return bindActionCreators({
    addRestaurant: addRestaurant
  }, dispatch);
};

export const ConnectedRestaurantInput = connect(null, mapDispatchToProps)(RestaurantInput)
