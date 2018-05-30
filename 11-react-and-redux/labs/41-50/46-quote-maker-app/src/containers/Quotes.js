import React, { Component } from 'react';
import { connect } from 'react-redux';
import QuoteCard from '../components/QuoteCard';
import { upvoteQuote, downvoteQuote, removeQuote } from '../actions/quotes';
import { bindActionCreators } from 'redux';

class Quotes extends Component {

  render() {
    return (
      <div>
        <hr />
        <div className="row justify-content-center">
          <h2>Quotes</h2>
        </div>
        <hr />
        <div className="container">
          <div className="row">
            <div className="col-md-4">
              {
                this.props.quotes.map((quote, i) =>
                  <QuoteCard
                    key={i}
                    quote={ quote }
                    upvoteQuote={ this.props.upvoteQuote }
                    downvoteQuote={ this.props.downvoteQuote }
                    removeQuote={ this.props.removeQuote }
                  />)
              }
            </div>
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    quotes: state.quotes
  }
}

const mapDispatchToProps = (dispatch) => {
  return bindActionCreators({
    upvoteQuote,
    downvoteQuote,
    removeQuote
  }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Quotes);
