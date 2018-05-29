import React, { Component } from 'react';

export default class UserInput extends Component {
  constructor(props){
    super(props);
    this.state = {
      username: '',
      hometown: ''
    };
  }

	onChangeHandler(e) {
    this.setState({
      [e.target.name]: e.target.value,
    });
  }

  onSubmitHandler(e) {
    e.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_USER',
      user: this.state,
    });
    this.setState({
      username: '',
      hometown: ''
    });
  }

  render() {
    return(
      <div>
        <form onSubmit={ this.onSubmitHandler.bind(this) }>
            <input
              type="text"
              name="username"
              value={this.state.username}
              onChange={ this.onChangeHandler.bind(this) }
          	/>
            <input
              type="text"
              name="hometown"
              value={this.state.hometown}
              onChange={ this.onChangeHandler.bind(this) }
						/>
          <input type="submit" value="Submit"/>
        </form>
      </div>
    );
  }
};
