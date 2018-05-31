import { combineReducers } from 'redux';
import catsReducer from './cats_reducer';

const combinedReducer = combineReducers({
  cats: catsReducer
});

export default combinedReducer;
