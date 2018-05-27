let state;

const changeState = (state = {count: 0}, action) =>{
  switch (action.type) {
    case 'INCREASE_COUNT':
      return {count: state.count + 1}
    case 'DECREASE_COUNT':
      return {count: state.count - 1}
    default:
      return state;
  }
}

const dispatch = (action) => {
  state = changeState(state, action);
  render();
};

const render = () => {
  let container = document.getElementById('container');
  container.textContent = state.count;
};

dispatch({ type: '@@INIT' });

// attach clickhandler which increases the count with each click
const onIncreaseClickHandler = (e) => dispatch({ type: 'INCREASE_COUNT' });
const onDecreaseClickHandler = (e) => dispatch({ type: 'DECREASE_COUNT' });
document.getElementById('increase').addEventListener('click', onIncreaseClickHandler);
document.getElementById('decrease').addEventListener('click', onDecreaseClickHandler);
