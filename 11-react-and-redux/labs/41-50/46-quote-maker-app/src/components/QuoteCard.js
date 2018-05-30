import React from 'react';

const QuoteCard = (props) => {
  function onUpvote(){
    props.upvoteQuote(props.quote.id);
  }

  function onDownvote(){
    props.downvoteQuote(props.quote.id);
  }

  function onRemoveQuote(){
    props.removeQuote(props.quote.id);
  }

  return (
    <div>
      <div className="card card-inverse card-success card-primary mb-3 text-center">
        <div className="card-block">
          <blockquote className="card-blockquote">
            <p>{ props.quote.content }</p>
            <footer>- author <cite title="Source Title">{ props.quote.author }</cite></footer>
          </blockquote>
        </div>
        <div className="float-right"> 
          <div className="btn-group btn-group-sm" role="group" aria-label="Basic example">
            <button 
              type="button" 
              className="btn btn-primary"
              onClick={onUpvote}>
              Upvote
            </button>
            <button 
              type="button" 
              className="btn btn-secondary"
              onClick={onDownvote}>
              Downvote
            </button>
            <button 
              type="button" 
              className="btn btn-danger"
              onClick={onRemoveQuote}>
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
           <div>Votes: { props.quote.votes }</div>
        </div>
      </div>
    </div>
  );
}

export default QuoteCard;
