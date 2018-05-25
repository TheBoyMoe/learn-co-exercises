import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import '../src/fetch-setup';
import FruitBasket from '../src/components/FruitBasket';

Enzyme.configure({ adapter: new Adapter() })

const Noop = () => (<p>Noop</p>);

describe('<FruitBasket />', () => {
  let wrapper;

  beforeEach(() => {
    wrapper = !FruitBasket.prototype ? shallow(<Noop />) :
      shallow(<FruitBasket  />);
  });

  it('should be a stateless functional component', () => {
    const tryToGetState = () => { wrapper.state(); }
    expect(tryToGetState).to.throw(
      'ShallowWrapper::state() can only be called on class components',
      'Component should not have state.'
    );
  });

  it('should have defaultProp "fruit"', () => {
    expect(FruitBasket.defaultProps, 'defaultProps not defined.').to.exist;
    expect(FruitBasket.defaultProps).to.have.any.key('fruit');
  });

  it('should have defaultProp "filters"', () => {
    expect(FruitBasket.defaultProps, 'defaultProps not defined.').to.exist;
    expect(FruitBasket.defaultProps).to.have.any.key('filters');
  });

  it('should have defaultProp "currentFilter"', () => {
    expect(FruitBasket.defaultProps, 'defaultProps not defined.').to.exist;
    expect(FruitBasket.defaultProps).to.have.any.key('currentFilter');
  });

  it('should have defaultProp "updateFilterCallback"', () => {
    expect(FruitBasket.defaultProps, 'defaultProps not defined.').to.exist;
    expect(FruitBasket.defaultProps).to.have.any.key('updateFilterCallback');
  });

  it('should have a top-level div with class "fruit-basket"', () => {
    expect(wrapper.find('div').hasClass('fruit-basket')).to.be.true;
  });

});
