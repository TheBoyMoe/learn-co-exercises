import { managePets, dispatch, state, render } from '../src/reducers/managePets';
import  jsdom from 'jsdom';
import sinon from 'sinon';

describe('managePets reducer', function() {

  it("returns the existing state if there action's type doesn't match a type in the reducer", function() {
    let state = {pets: [{name: 'Splash', type: 'turtle', id: 100}]}
    expect(managePets(state, {type: 'Random Action Type'})).toEqual(state);
  })

  it("adds the pet when type is ADD_PET and the action has a pet property with the pet's name, species and id", function(){
    let state = {pets: [{name: 'Splash', type: 'turtle', id: 100}]}
    expect(managePets(state, {type: "ADD_PET", pet: {name: 'avalanche', species: 'puppy', id: 101}})).toEqual({pets: [{name: 'Splash', type: 'turtle', id: 100}, {name: 'avalanche', species: 'puppy', id: 101}]});
  })

  it("removes the pet when action type is REMOVE_PET and the action has a property of id for the pet to be removed", function(){
    let state = {pets: [{name: 'Splash', species: 'Turtle'}, {name: 'avalanche', species: 'puppy', id: 101}, {name: 'sally', species: 'camel', id: 102}]}
    expect(managePets(state, {type: "REMOVE_PET", id: 101})).toEqual({pets: [{name: 'Splash', species: 'Turtle'}, {name: 'sally', species: 'camel', id: 102}]});
  })

  it("adheres to the rules of being a pure function, by not changing the original state, and instead returning a new object", function(){
    let state = Object.freeze({pets: [{name: 'Splash', species: 'Turtle'}, {name: 'avalanche', species: 'puppy', id: 101}, {name: 'sally', species: 'camel', id: 102}]})
    managePets(state, {type: "REMOVE_PET", id: 101})
    expect(state).toEqual({pets: [{name: 'Splash', species: 'Turtle'}, {name: 'avalanche', species: 'puppy', id: 101}, {name: 'sally', species: 'camel', id: 102}]})
  })

  it('has a default argument for state', function(){
    let state;
    expect(managePets(state, {type: "@@INIT"})).toEqual({pets: []})
  })
})

describe('dispatch', function(){

  it('declares the state variable in the global scope and exports the state, and calls the reducer', function(){
    // you are exporting the state for the purposes of the test only
    global.document = jsdom.jsdom('<html><body><div id="container"></div></body></html>');
    expect(state).toEqual(undefined)
    dispatch({type: "@@INIT"})
    expect(state).toEqual({pets: []})
  })
})

describe('render', function(){
  it('displays the state on the html', function(){
    global.document = jsdom.jsdom('<html><body><div id="container"></div></body></html>');
    dispatch({type: 'ADD_PET', pet: {name: 'Splash', species: 'Turtle', id: 100}})
    render()
    let container = document.getElementById('container')
    expect(container.innerHTML).toEqual('<ul><li>Splash</li></ul>')
  })
})

describe('dispatch with render', function(){
  it('calls the render function which displays the updated html', function(){
    // need to reload the managePets file to reset the state variable.
      delete require.cache[require.resolve('../src/reducers/managePets')];
      let reducer = require('../src/reducers/managePets');

    global.document = jsdom.jsdom('<html><body><div id="container"></div></body></html>');

    reducer.dispatch({type: 'ADD_PET', pet: {name: 'Splash', species: 'Turtle', id: 100}})
    let container = document.getElementById('container')
    expect(container.innerHTML).toEqual('<ul><li>Splash</li></ul>')
  })
})
