import React, { Component } from 'react';
import './App.css';

export default class App extends Component {
  onClickHandler(){
    this.props.store.dispatch({
      type: 'INCREASE_COUNT'
    });
  }

  render() {
    return (
      <div className="App">
        <p>{ this.props.store.getState().items.length }</p>
        <button onClick={ this.onClickHandler.bind(this) }>Click</button>
      </div>
    );
  }
};

