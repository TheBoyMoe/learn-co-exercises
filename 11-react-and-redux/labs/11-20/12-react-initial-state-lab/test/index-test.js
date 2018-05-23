import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import ImageSlider from '../src/components/ImageSlider';
import Bomb from '../src/components/Bomb';

Enzyme.configure({ adapter: new Adapter() })

describe('<ImageSlider />', function () {
  const wrapper = shallow(<ImageSlider/>);

  it('should set the `currentSlideIndex` to 0 on its state', function () {
    expect(wrapper.state('currentSlideIndex')).to.equal(0);
  });

  it('render the correct text', function () {
    expect(wrapper.text()).to.equal('I am on slide 0');
  });
});

describe('<Bomb />', function () {
  const wrapper = shallow(<Bomb initialCount={120} />);

  it('should set the `secondsLeft` to the value of the `initialCount` prop', function () {
    expect(wrapper.state('secondsLeft')).to.equal(120);
  });

  it('render the correct text when the timer is not 0', function () {
    expect(wrapper.text()).to.equal('120 seconds left before I go boom!');
  });

  it('render the correct text when the timer is 0', function () {
    const wrapper = shallow(<Bomb initialCount={0} />);
    expect(wrapper.text()).to.equal('Boom!');
  });
});
