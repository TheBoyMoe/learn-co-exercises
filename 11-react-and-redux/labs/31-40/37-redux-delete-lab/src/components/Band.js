import React, { Component } from 'react';

class Band extends Component {
  onClickHandler(){
    console.log('Clicked');
    this.props.store.dispatch({
      type: 'DELETE_BAND',
      id: this.props.band.id
    });
  }

  // this.onClickHandler.bind(this) OR () => this.onClickHandler() to make sure 'this' is bound
  render() {
    return(
      <li>
        { this.props.band.text }
        <button onClick={() => this.onClickHandler()}>Delete</button>
      </li>
    );
  }
};

export default Band;
