import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import '../src/fetch-setup';
import FilteredFruitList from '../src/components/FilteredFruitList';

Enzyme.configure({ adapter: new Adapter() })

const Noop = () => (<p>Noop</p>);
const fruit = [
  { name: 'grapes',
    keywords: [ 'fruit', 'food', 'wine' ],
    char: '🍇',
    fruit_type: 'berry' },
  { name: 'green_apple',
    keywords: [ 'fruit', 'nature' ],
    char: '🍏',
    fruit_type: 'pome' },
  { name: 'apple',
    keywords: [ 'fruit', 'mac', 'school' ],
    char: '🍎',
    fruit_type: 'pome' },
  { name: 'peach',
    keywords: [ 'fruit', 'nature', 'food' ],
    char: '🍑',
    fruit_type: 'drupe' }
];

describe('<FilteredFruitList />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = !FilteredFruitList.prototype ? shallow(<Noop />) :
      shallow(<FilteredFruitList fruit={fruit} filter={null} />);
  });

  it('should be a stateless functional component', () => {
    const tryToGetState = () => { wrapper.state(); }
    expect(tryToGetState).to.throw(
      'ShallowWrapper::state() can only be called on class components',
      'Component should not have state.'
    );
  });

  it('should have a defaultProp "fruit"', () => {
    const defaultProps = FilteredFruitList.defaultProps;
    expect(defaultProps, 'defaultProps is not defined.').to.exist;
    expect(defaultProps).to.have.any.key('fruit');
  });

  it('should have a defaultProp "filter"', () => {
    const defaultProps = FilteredFruitList.defaultProps;
    expect(defaultProps, 'defaultProps is not defined.').to.exist;
    expect(defaultProps).to.have.any.key('filter');
  });

  it('should have a top-level ul element with class "fruit-list"', () => {
    expect(wrapper.find('ul').hasClass('fruit-list')).to.be.true;
  });

  it('should render entire fruit list when filter is null', () => {
    expect(wrapper.find('li').length).to.equal(4, 'Failed to render full list.');
  });

  it('should render list of correct length when "pome" filter applied', () => {
    wrapper = !FilteredFruitList.prototype ? shallow(<Noop />) :
      shallow(<FilteredFruitList fruit={fruit} filter='pome' />);
    expect(wrapper.find('li').length).to.equal(2, 'Fruit list wrong length given filter "pome".');
  });

  it('should only list fruit of type pome when pome filter applied', () => {
    wrapper = !FilteredFruitList.prototype ? shallow(<Noop />) :
      shallow(<FilteredFruitList fruit={fruit} filter='pome' />);
    expect(wrapper.find('li').length).to.equal(2, 'No fruit in list.');
    wrapper.find('li').forEach(n => {
      expect(n.text()).to.match(/🍏|🍎/,
        'One of the fruits listed did not fit the filter.')
    });
  });

});
