import React from 'react';
import { expect } from 'chai'
import Enzyme, { shallow, mount } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import SearchableMovieReviewsContainer from '../src/components/SearchableMovieReviewsContainer';
import testReviews from './test-reviews';

Enzyme.configure({ adapter: new Adapter() })

const Noop = (props) => { return <p>Noop</p> };

describe('<SearchableMovieReviewsContainer />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = !SearchableMovieReviewsContainer.prototype ?
      shallow(<Noop />) : shallow(<SearchableMovieReviewsContainer />);
  });

  it('should have state', () => {
    const tryToGetState = () => { wrapper.state(); }
    expect(SearchableMovieReviewsContainer.prototype, 'Component is not yet defined.').to.exist;
    expect(tryToGetState).to.not.throw('Component should be class component.');
  });

  it('should have the state properties "reviews" and "searchTerm"', () => {
    expect(SearchableMovieReviewsContainer.prototype, 'Component is not yet defined.').to.exist;
    expect(wrapper.state()).to.have.all.keys('searchTerm', 'reviews');
  });

  it('should have top-level element with class "searchable-movie-reviews"', () => {
    expect(wrapper.hasClass('searchable-movie-reviews'), 'Missing top-level element with class "searchable-movie-reviews"').to.be.true;
  });

  it('should render reviews after reviews state updated', () => {
    wrapper = !SearchableMovieReviewsContainer.prototype ?
      mount(<Noop />) : mount(<SearchableMovieReviewsContainer />);
    wrapper.setState({ reviews: testReviews });
    wrapper.update();
    expect(wrapper.find('.review').length).to.equal(testReviews.length);
  });
});
