import React from 'react';
import Tweet from './Tweet';

class TweetWall extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      tweets: []
    };
  }

  // set the initial tweets
  componentWillMount = () => {
    this.setState({
      tweets: this.props.newTweets
    });
  };

  // update the tweets
  shouldComponentUpdate = (nextProps) => {
    this.setState({
      tweets: [...nextProps.newTweets, ...this.state.tweets]
    });
  }

  componentWillReceiveProps = (nextProps) => nextProps.newTweets.length > 0;

  render() {
    const tweets = this.state.tweets.map((tweet, index) => <Tweet text={tweet.text} key={index} />);

    return (
      <div>{tweets}</div>
    );
  }
}

export default TweetWall;
