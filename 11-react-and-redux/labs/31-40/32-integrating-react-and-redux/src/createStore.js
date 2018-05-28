// implement store
import { render } from './index';

const createStore = (reducer) => {
  let state;

  function dispatch(action){
    state = reducer(state, action);
    console.log('state: ', state.count, ', action: ', action.type);
    render();
  }

  function getState(){
    return state;
  }

  return {
    dispatch,
    getState
  };
}
export default createStore;
