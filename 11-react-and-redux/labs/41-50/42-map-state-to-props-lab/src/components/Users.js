import React, { Component } from 'react';
import { connect } from 'react-redux';

export class Users extends Component {

  render() {
    const users = this.props.users.map((user, i) => {
      return <li key={i}>{ user.userName }</li>
    });

    return (
      <div>
        <ul>
          { users }
        </ul>
      </div>
    )
  }
}
const mapStateToProps = (state) => {
  return {
    users: state.users,
    primaryUser: state.users[0]
  }
};

export const ConnectedUsers = connect(mapStateToProps)(Users);

