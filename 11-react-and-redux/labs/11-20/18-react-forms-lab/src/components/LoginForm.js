import React from "react";

export default class LoginForm extends React.Component {
  constructor() {
    super();
    this.state = {
      username: '',
      password: ''
    };
  }

  usernameChangeHandler = (e) => {
    this.setState({
      username: e.target.value
    });
  };

  passwordChangeHandler = (e) => {
    this.setState({
      password: e.target.value
    });
  };

  formSubmit = (e) => {
    e.preventDefault();
    const username = this.state.username;
    const password = this.state.password;
    if(username && password){
      this.props.onSubmit({ username, password });
    }
  };

  render() {
    return (
      <form onSubmit={ this.formSubmit }>
        <div>
          <label>
            Username
            <input 
              id="test-username" 
              type="text" 
              name="username" 
              value={ this.state.username } 
              onChange={ this.usernameChangeHandler } />
          </label>
        </div>
        <div>
          <label>
            Password
            <input 
              id="test-password" 
              type="password" 
              value={ this.state.password } 
              onChange={ this.passwordChangeHandler }
            />
          </label>
        </div>
        <div>
          <button type="submit">Log in</button>
        </div>
      </form>
    );
  }
}

