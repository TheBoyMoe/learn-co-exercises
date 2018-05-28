import React from 'react';

export default class BandInput extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      text: ''
    };
  }

  onChangeHandler = (event) => {
    this.setState({
      text: event.target.value
    });
  };

  onSubmitHandler = (event) => {
    event.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_BAND',
      band: this.state.text
    });
    this.setState({
      text: ''
    });
  };

  render() {
    return (
      <div>
        <form onSubmit={(e) => this.onSubmitHandler(e)}>
          <label>Add band</label>
          <input 
            type="text"
            value={ this.state.text }
            onChange={(e) => this.onChangeHandler(e)}
          />
          <input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
};

