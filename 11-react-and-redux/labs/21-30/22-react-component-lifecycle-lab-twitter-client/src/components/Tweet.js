import React from 'react';

class Tweet extends React.Component {

  render() {
    return (
      <div className="tweet">{this.props.text}</div>
    )
  }
}

export default Tweet;
