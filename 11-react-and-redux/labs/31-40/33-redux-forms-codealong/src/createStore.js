import { render } from './index.js'

export default function createStore(reducer){
  let state;

  function dispatch(action){
    state = reducer(state, action);
    console.log(`state: `, state, ', action: ', action.type);
    render();
  };

  function getState(){
    return state;
  };

  return {
    dispatch,
    getState
  };
};
