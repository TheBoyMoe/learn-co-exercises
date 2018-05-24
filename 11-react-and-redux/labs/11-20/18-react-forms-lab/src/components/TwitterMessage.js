import React from "react";

export default class TwitterMessage extends React.Component {
  constructor() {
    super();
    this.state = {
      value: ''
    };
  }

  onChangeHandler = (e) => {
    const text = e.target.value;
    if(text && text.length <= 140){
      this.setState({
        value: text
      })
    }
  };

  render() {
    return (
      <div>
        <strong>Your message:</strong>
        <input 
          type="text"
          value={ this.state.value }
          onChange={ this.onChangeHandler }
        />
        <p>Remaining characters: { 140 - this.state.value.length }</p>
      </div>
    );
  }
}

