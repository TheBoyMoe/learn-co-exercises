import React from 'react';
import expect from 'expect';
import { mount } from 'enzyme';
import store from '../src/configureStore';
import FakeProvider from './FakeProvider';
import PetsNew from '../src/containers/PetsNew';

describe('PetsNew', () => {
  it('renders the form to create a new Pet', () => {
    const wrapper = mount(<FakeProvider><PetsNew /></FakeProvider>);
    expect(wrapper.find('form').length).toEqual(1, 'Pets New Component should contain a form');
  })
})
