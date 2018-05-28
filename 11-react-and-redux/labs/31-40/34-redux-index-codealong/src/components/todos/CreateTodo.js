import React from 'react';

export default class CreateTodo extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      text: ''
    };
  }

  handleChange(event) {
    this.setState({
      text: event.target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_TODO',
      todo: this.state,
    });
    this.setState({
      text: ''
    });
  }

  render() {
    return(
      <div>
        <form onSubmit={(event) => this.handleSubmit(event)}>
          <p>
            <label>add todo</label>
            <input 
              type="text" 
              onChange={(e) => this.handleChange(e)} 
              value={ this.state.text }
            />
          </p>
          <input type="submit" />
        </form>
      </div>
    );
  }
};

