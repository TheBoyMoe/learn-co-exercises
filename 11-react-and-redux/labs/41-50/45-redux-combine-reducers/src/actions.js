// action creators
export function addBook(book){
  return {
    type: 'ADD_BOOK',
    payload: book
  }
}

export function addRecommendedBook(book){
  return {
    type: 'ADD_RECOMMENDED_BOOK',
    payload: book
  }
}

export function removeBook(book){
  return {
    type: 'REMOVE_BOOK',
    payload: book
  }
}

export function removeRecommendedBook(book){
  return {
    type: 'REMOVE_RECOMMENDED_BOOK',
    payload: book
  }
}

