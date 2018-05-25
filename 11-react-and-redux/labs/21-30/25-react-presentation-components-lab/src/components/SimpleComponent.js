import React from 'react';

export default class SimpleComponent extends React.Component {
  constructor(){
    super();
    this.state = {
      mood: 'happy'
    };
  }

  handleClick = (e) => {
    const mood = (this.state.mood === 'happy')? 'sad' : 'happy';
    this.setState({
      mood
    });
  };

  render(){
    return (
      <div onClick={ this.handleClick }>{ this.state.mood }</div>
    );
  };
}
