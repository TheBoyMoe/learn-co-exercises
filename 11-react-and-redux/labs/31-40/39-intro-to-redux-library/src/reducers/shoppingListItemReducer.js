export default function shoppingListItemReducer(state = {items: []}, action) {
  switch(action.type) {
    case 'INCREASE_COUNT':
      console.log('current item length', state.items.length);
      return Object.assign({}, state, { items: state.items.concat(state.items.length + 1) });
    default:
      console.log('initial item length', state.items.length);
      return state;
  }
}
