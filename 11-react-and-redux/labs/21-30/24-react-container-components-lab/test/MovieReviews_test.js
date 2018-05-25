import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import MovieReviews from '../src/components/MovieReviews';
import testReviews from './test-reviews';

Enzyme.configure({ adapter: new Adapter() })

const Noop = (props) => { return <p>Noop</p> };

describe('<MovieReviews />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = !MovieReviews.prototype ?
      shallow(<Noop />) : shallow(<MovieReviews reviews={testReviews} />);
  });

  it('should be a stateless functional component', () => {
    const tryToGetState = () => { wrapper.state(); }
    expect(MovieReviews.prototype, 'Component is not yet defined.').to.exist;
    expect(tryToGetState).to.throw(
      'ShallowWrapper::state() can only be called on class components',
      'Component should not have state.'
    );
  });

  it('should have defaultProp "reviews"', () => {
    const defaultProps = MovieReviews.defaultProps;
    expect(defaultProps, 'defaultProps is not defined.').to.exist;
    expect(defaultProps).to.have.key('reviews');
  });

  it('should have a top-level component with class "review-list"', () => {
    expect(wrapper.hasClass('review-list')).to.be.true;
  });

  it('should render all the reviews', () => {
    expect(wrapper.find('.review').length).to.equal(testReviews.length);
  });
});
