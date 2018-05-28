import React from 'react'

export default class CreateTodo extends React.Component {
  constructor(){
    super();
    this.state = {
      text: ''
    };
  }

  onChangeHandler(e) {
    this.setState({
      text: e.target.value
    });
  };

  onSubmitHandler(e) {
    e.preventDefault();
    this.props.store.dispatch({
      type: 'ADD_TODO',
      todo: this.state
    });
  }

  render(){
    return(
      <div>
        <form onSubmit={(e) => this.onSubmitHandler(e) }>
          <p>
            <label>add todo</label>
            <input 
              type="text"
              onChange={(e) => this.onChangeHandler(e)}
            />
          </p>
          <input type="submit" value="Submit" />
        </form>
        { this.state.text }
      </div>
    )
  }
}

