// upvote/down vote alter position quote cards
export default (state = [], action) => {
  switch(action.type){
    case 'ADD_QUOTE':
      return [...state, action.quote];
    case 'REMOVE_QUOTE':
      return state.filter(quote => quote.id !== action.quoteId);
    case 'UPVOTE_QUOTE':
      let up = state.filter(quote => quote.id === action.quoteId)[0];
      up.votes = ++up.votes;
      return state.filter(quote => quote.id !== action.quoteId).concat(up);
    case 'DOWNVOTE_QUOTE':
      let down = state.filter(quote => quote.id === action.quoteId)[0];
      down.votes = (down.votes > 0)? --down.votes : 0; 
      return state.filter(quote => quote.id !== action.quoteId).concat(down);
    default:
      return state;
  }
}
