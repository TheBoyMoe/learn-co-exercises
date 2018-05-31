import React from 'react';
import expect from 'expect';
import { mount } from 'enzyme';

import FakeProvider from './FakeProvider';
import PetsShow from '../src/containers/PetsShow';

describe('PetsShow', () => {

  it('renders the pets show component', () => {
    const matchParams = { params: { petId: 1 } }
    const wrapper = mount(<FakeProvider>< PetsShow match={matchParams} /></FakeProvider>);
    expect(wrapper.find('h2').length).toEqual(1, 'Pets show should have an h2 with the pets name');
    expect(wrapper.find('h2').text()).toEqual('Grover');
  })

  it('finds the pet by the route ID', () => {
    const matchParams = { params: { petId: 2 } }
    const wrapper = mount(<FakeProvider>< PetsShow match={matchParams} /></FakeProvider>);
    expect(wrapper.find('h2').length).toEqual(1, 'The name should be based on the id of the pet');
    expect(wrapper.find('h2').text()).toEqual('Fido');
  })
})
