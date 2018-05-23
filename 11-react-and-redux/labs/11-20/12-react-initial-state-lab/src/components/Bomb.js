import React from 'react';

// Bomb Component Code Goes Here
export default class Bomb extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      secondsLeft: props.initialCount
    };
  }

  render(){
    const time = this.state.secondsLeft;
    return (
      (time > 0)? <p>{ time } seconds left before I go boom!</p> : <p>Boom!</p>
    );
  };
}
