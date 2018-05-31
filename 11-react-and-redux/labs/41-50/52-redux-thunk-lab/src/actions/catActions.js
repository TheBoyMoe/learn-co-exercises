import fetch from 'isomorphic-fetch';

export function fetchCats() {
  return (dispatch) => {
    dispatch({ type: 'LOADING_CATS' });
    return fetch('http://localhost:4000/db')
      .then(res => res.json())
      .then(resJson => resJson.images)
      .then(cats => dispatch({
        type: 'FETCH_CATS', 
        payload: cats 
    }));
  };
}
