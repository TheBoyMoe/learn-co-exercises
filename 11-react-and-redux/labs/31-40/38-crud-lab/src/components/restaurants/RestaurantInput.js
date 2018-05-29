import React, { Component } from 'react';

class RestaurantInput extends Component {
  constructor(props){
    super(props);
    this.state = {
      text: ''
    }
  }

  onSubmitHandler(e){
    e.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_RESTAURANT',
      restaurant: {
        text: this.state.text
      }
    });
    this.setState({
      text: ''
    });
  }

  onChangeHandler(e){
    this.setState({
      text: e.target.value
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
      </div>
    );
  }
};

export default RestaurantInput;
