import React from 'react';
import { expect } from 'chai';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import sinon from 'sinon';

import '../src/fetch-setup';
import Filter from '../src/components/Filter';

Enzyme.configure({ adapter: new Adapter() })

const Noop = () => (<p>Noop</p>);
const filters = [ 'filter1', 'filter2', 'filter3' ];

describe('<Filter />', () => {
  let spy = sinon.spy();
  let wrapper;

  beforeEach(() => {
    wrapper = !Filter.prototype ?
      shallow(<Noop />) : shallow(<Filter filters={filters} handleChange={spy}/>);
  });

  it('should be a stateless functional component', () => {
    const tryToGetState = () => { wrapper.state(); }
    expect(tryToGetState).to.throw(
      'ShallowWrapper::state() can only be called on class components',
      'Component should not have state.'
    );
  });

  it('should have a defaultProp "filters"', () => {
    expect(Filter.defaultProps, 'defaultProps is not defined.').to.exist;
    expect(Filter.defaultProps).to.have.any.keys('filters');
  });

  it('should have a defaultProp "handleChange"', () => {
    expect(Filter.defaultProps, 'defaultProps is not defined.').to.exist;
    expect(Filter.defaultProps).to.have.any.key('handleChange');
  });

  it('should call "handleChange" callback when there is a change', () => {
    wrapper.find('select').simulate('change');
    expect(spy.calledOnce).to.be.true;
  });

  it('should render a select element with a default option "all"', () => {
    expect(wrapper.find('select').childAt(0).prop('value')).to.equal('all');
  });

  it('should render all the provided "filters"', () => {
    const options = wrapper.find('option');
    expect(options.length).to.equal(4, 'Did not render all the filters.');
  });
});
