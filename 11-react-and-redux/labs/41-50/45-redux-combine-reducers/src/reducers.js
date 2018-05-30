import { combineReducers } from 'redux';

export function books(state = [], action){
  switch(action.type){
    case 'ADD_BOOK':
      return [...state, action.payload];
    case 'REMOVE_BOOK':
      let i = state.indexOf(action.payload);
      return [].concat(state.slice(0, i), state.slice(i + 1, state.length));
    default:
      return state;
  }
}

export function recommendedBooks(state = [], action){
  switch(action.type){
    case 'ADD_RECOMMENDED_BOOK':
      return [...state, action.payload];
    case 'REMOVE_RECOMMENDED_BOOK':
      let i = state.indexOf(action.payload);
      return [].concat(state.slice(0, i), state.slice(i + 1, state.length));
    default:
      return state;
  }
}

const rootReducer = combineReducers({ books, recommendedBooks });
