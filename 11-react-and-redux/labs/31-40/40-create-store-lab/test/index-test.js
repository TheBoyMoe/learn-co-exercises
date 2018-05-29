import { expect } from 'chai';
import sinon from 'sinon';
import { shallow, mount } from 'enzyme';
import React from 'react';
import UserInput from '../src/components/UserInput';
import { configureStore } from '../src/index.js';

describe('store', () => {

  let store = configureStore();

  it('returns the initial state after redux dispatches its initial action', () => {
    expect(store.getState()).to.deep.equal({ users: [] });
  });

  it('updates the state when an action is dispatched', () => {
    store.dispatch({
      type: 'ADD_USER',
      user: {
        username: 'bob',
        hometown: 'philly'
      },
    });
    expect(store.getState()).to.deep.equal({ users: [ { username: 'bob', hometown: 'philly' } ] });
  });
});


describe('UserInput', () => {

  let store = configureStore();

  it('has an text input for the username field', () => {
    const wrapper = shallow(<UserInput />);
    expect(wrapper.find('input').first().type()).to.equal('input');
  });

  it('has an initial state with username key set to empty string', () => {
    const wrapper = shallow(<UserInput />);
    expect(wrapper.state('username')).to.equal('');
  });

  it('has an initial state with hometown key set to empty string', () => {
    const wrapper = shallow(<UserInput />);
    expect(wrapper.state('hometown')).to.equal('');
  });

  it('has changes the state of username on change of the username input', () => {
    const wrapper = shallow(<UserInput />);
    expect(wrapper.state('username')).to.equal('');
    let input = wrapper.find('input').first();
    input.simulate('change', { target: { value: 'Hello', name: 'username' } });
    expect(wrapper.state('username')).to.equal('Hello');
  })

  it('has changes the state of hometown on change of the hometown input', () => {
    const wrapper = shallow(<UserInput />);
    expect(wrapper.state('hometown')).to.equal('');
    let input = wrapper.find({type: 'text'}).last();
    input.simulate('change', { target: { value: 'Hello', name: 'hometown' } });
    expect(wrapper.state('hometown')).to.equal('Hello');
  })

  it('updates the store when the form is submitted', () => {
    let store = configureStore();
    const wrapper = shallow(<UserInput store={store} />);
    expect(wrapper.state('hometown')).to.equal('');
    let usernameInput = wrapper.find('input').first();
    usernameInput.simulate('change', { target: { value: 'Bob', name: 'username' } });
    let hometownInput = wrapper.find({ type: 'text' }).last();
    hometownInput.simulate('change', { target: { value: 'philly', name: 'hometown' } });
    let form = wrapper.find('form').first();
    form.simulate('submit',  { preventDefault() {} });
    expect(store.getState()).to.deep.equal({ users: [ { username: 'Bob', hometown: 'philly' } ] });
  });
});
