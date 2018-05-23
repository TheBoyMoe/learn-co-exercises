// Code ClickityClick Component Here
import React from 'react';

export default class ClickityClick extends React.Component {
  constructor(){
    super();
    this.state = {
      hasBeenClicked: false
    };
  }

  onClickHandler = () => {
    // setState() is not synchronous, state updates are batched and run when appropriate
    // they are asynchronous, we can add a callback which will be called when the operation has completed
    this.setState({
      hasBeenClicked: true
    }, () => console.log('callback', this.state.hasBeenClicked)); //=> true
    console.log(this.state.hasBeenClicked); //=> false
  };

  render(){
    return (
      <div>
        <p>I have { this.state.hasBeenClicked? null : 'not'} been clicked!</p>
        <button onClick={ this.onClickHandler }>Clicke Me!</button>
      </div>
    );
  };
}
