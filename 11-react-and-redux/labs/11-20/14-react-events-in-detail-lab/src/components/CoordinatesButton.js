// Code CoordinatesButton Component Here
import React from 'react';

export default class CoordinatesButton extends React.Component {
  onClickHandler = (e) => {
    let x = e.clientX;
    let y = e.clientY;
    this.props.onReceiveCoordinates([x, y]);
  };

  render(){
    return (
      <button onClick={ this.onClickHandler } >Click Me!</button>
    );
  };
}
