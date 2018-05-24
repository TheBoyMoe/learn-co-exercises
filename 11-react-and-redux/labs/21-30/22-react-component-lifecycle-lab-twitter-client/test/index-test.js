import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow, mount } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16'
import sinon from 'sinon';

import App from '../src/components/App';
import TweetWall from '../src/components/TweetWall';

Enzyme.configure({ adapter: new Adapter() })

describe('App', () => {
  const fetchTweetsStub = sinon.stub();
  const startIntervalStub = sinon.stub();
  const cleanUpIntervalStub = sinon.stub();

  class AppWrapper extends App {
    constructor(props) {
      super(props);
      this.fetchTweets = fetchTweetsStub;
      this.startInterval = startIntervalStub;
      this.cleanUpInterval = cleanUpIntervalStub;
    }
  }

  it('will fetch a set of tweets on the initial render', () => {
    fetchTweetsStub.reset();
    mount(<AppWrapper />)
    expect(fetchTweetsStub.calledOnce).to.be.true;
  });

  it('sets up the interval updating the tweets every few seconds', () => {
    startIntervalStub.reset();
    mount(<AppWrapper />)
    expect(startIntervalStub.calledOnce).to.be.true;
  });

  it('cleans up the interval when the component is destroyed', () => {
    cleanUpIntervalStub.reset();
    let wrapper = mount(<AppWrapper />)
    wrapper.unmount()
    expect(cleanUpIntervalStub.calledOnce).to.be.true;
  });
});

describe('TweetWall', () => {
  it('will save the first lot of newTweets into the state at componentWillMount', () => {
    const wrapper = shallow(<TweetWall newTweets={['I am a tweet!']} />);
    expect(wrapper.state()).to.deep.equal({ tweets: ['I am a tweet!'] });
  });

  it('updates the state to incorporate new tweets', () => {
    const wrapper = shallow(<TweetWall newTweets={['I am a tweet!']} />);
    wrapper.setProps({ newTweets: ['I am also a tweet!'] });
    expect(wrapper.state()).to.deep.equal({ tweets: ['I am also a tweet!', 'I am a tweet!'] });
  });

  it('updates the state to incorporate new tweets', () => {
    const wrapper = shallow(<TweetWall newTweets={['I am a tweet!']} />);
    wrapper.setProps({ newTweets: ['I am also a tweet!'] });
    expect(wrapper.state()).deep.equal({ tweets: ['I am also a tweet!', 'I am a tweet!'] });
  });

  it('does not rerender when there are no new tweets', () => {
    const spy = sinon.spy(TweetWall.prototype, 'render')
    const wrapper = shallow(<TweetWall newTweets={[]}  />);
    wrapper.setProps({ newTweets: [] });
    expect(spy).to.have.property('callCount', 1)
  });
});
