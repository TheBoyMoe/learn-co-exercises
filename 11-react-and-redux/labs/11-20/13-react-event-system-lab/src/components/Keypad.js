// Code Keypad Component Here
import React from 'react';

export default class Keypad extends React.Component {
  keyUpHandler = () => {
    console.log('Entering password...');
  }; 
  
  render(){
    return (
      <input onKeyUp={ this.keyUpHandler } type="password" />
    );
  };
}
