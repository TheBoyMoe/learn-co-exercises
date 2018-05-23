// Code EyesOnMe Component Here
import React from 'react';

export default class EyesOnMe extends React.Component {
  onFocusHandler = () => {
    console.log('Good!');
  };

  onBlurHandler = () => {
    console.log('Hey! Eyes on me!');
  };

  render(){
    return (
      <button onFocus={ this.onFocusHandler } onBlur={ this.onBlurHandler }>Click Me!</button>
    );
  };
}
