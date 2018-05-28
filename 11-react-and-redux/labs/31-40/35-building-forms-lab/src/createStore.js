import { renderer } from './index.js';

export default function createStore(reducer){
  let state;

  function dispatch(action) {
    state = reducer(state, action);
    if (process.env.NODE_ENV !== 'test') {
      console.log('state: ', state, ', action: ', action.type);
    }
    renderer.render()
  };

  function getState(){
    return state;
  };

  return {
    dispatch, 
    getState
  };
};
