import React, { Component } from 'react';
import './App.css';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { addItem } from  './actions/items';

class App extends Component {

  handleOnClick() {
    this.props.addItem(); // calls the action creator
  }

  render() {
    return (
      <div className="App">
        <button onClick={ this.handleOnClick.bind(this) }>Click</button>
        <p>{this.props.items.length}</p>
      </div>
    );
  }
};

const mapStateToProps = (state) => {
  return {
    items: state.items
  };
};

// bind the action creater to dispatch so dispatch
// is called when the action creator is invoked
const mapDispatchToProps = (dispatch) => {
  return bindActionCreators({
    addItem: addItem
  }, dispatch);
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
