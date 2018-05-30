// action creators as defined in tests
export function addQuote(quote){
  return {
    type: 'ADD_QUOTE',
    quote: Object.assign({}, quote, {votes: 0})
  }
}

export function removeQuote(quoteId){
  return {
    type: 'REMOVE_QUOTE',
    quoteId
  }
}

export function upvoteQuote(quoteId){
  return {
    type: 'UPVOTE_QUOTE',
    quoteId
  }
}

export function downvoteQuote(quoteId){
  return {
    type: 'DOWNVOTE_QUOTE',
    quoteId
  }
}
