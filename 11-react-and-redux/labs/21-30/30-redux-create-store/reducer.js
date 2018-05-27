// createStore() is generic, can be used with any implementation
// by passing in the reducer as an argument
function createStore(reducer) {
  let state;

  function dispatch(action) {
    state = reducer(state, action);
    render();
  }

  function getState() { return state; }

  // initialize the state when the store is set with 
  // the default value set by the reducer
  dispatch({type: '@@INIT'});

  return {
    dispatch,
    getState
  };
}

// All we need to do is implement the reducer and render() 
// functions which are specific to the implementation
function changeCount(state = {count: 0}, action) {
  switch (action.type) {
    case 'INCREASE_COUNT':
      return { count: state.count + 1 };
    case 'DECREASE_COUNT':
      return { count: state.count - 1 };
    default:
      return state;
  }
}

function render() {
  let container = document.getElementById('container')
  container.textContent = store.getState().count;
}

const store = createStore(changeCount);

document.getElementById('button').addEventListener('click', () => store.dispatch({type: 'INCREASE_COUNT'}));
