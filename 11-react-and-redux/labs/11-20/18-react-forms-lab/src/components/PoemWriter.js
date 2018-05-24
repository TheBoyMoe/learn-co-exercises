import React from "react";

export default class PoemWriter extends React.Component {
  constructor() {
    super();
    this.state = {
      value: '',
      valid: false
    };
  }

  textareaChangeHandler = (e) => {
    const text = e.target.value;
    if(text){
      this.setState({
        value: text
      });
    }
    const lines = text.split(/\r\n|\r|\n/);
    let firstCount, secondCount, thirdCount;

    if(lines[0]){
      firstCount = lines[0].trim().split(' ').length;
    }
    if(lines[1]){
      secondCount = lines[1].trim().split(' ').length;
    }
    if(lines[2]){
      thirdCount = lines[2].trim().split(' ').length;
    }
    if(lines.length === 3 && firstCount === 5 && secondCount === 3 && thirdCount === 5){
      this.setState({
        valid: true
      });
    }
  };

  render() {
    return (
      <div>
        <textarea 
          rows="3" 
          cols="60"
          value={ this.state.value }
          onChange={ this.textareaChangeHandler }
        />
        { 
          (!this.state.valid) &&
            (<div 
              id="poem-validation-error" 
              style={{ color: "red" }}>
              This poem is not written in the right structure!
            </div>)
        }
      </div>
    );
  }
}

