import React from 'react';
import MovieReviews from './MovieReviews';
require('isomorphic-fetch');
require('es6-promise').polyfill();

const NYT_API_KEY = '91acd1323e694da8b4548f80a4f8ffc8';
const URL = 'https://api.nytimes.com/svc/movies/v2/reviews/search.json?'
            + `api-key=${NYT_API_KEY}&query=`;

export default class SearchableMovieReviewsContainer extends React.Component {
  constructor(){
    super();
    this.state = {
      reviews: [],
      searchTerm: ''
    };
  }

  onChangeHandler = (e) => {
    let query = e.target.value;
    this.setState({
      searchTerm: query
    });
  }

  onSubmitHandler = (e) => {
    e.preventDefault();
    fetch(URL + `${ this.state.searchTerm }`)
      .then((res) => {
        if(res.status >= 400)
          throw new Error('Error occurred');
        return res.json();
      })
      .then((reviewsObj) => {
        this.setState({
          reviews: reviewsObj.results
        });
        // console.log(this.state.reviews);
      });
  };

  render(){
    return (
      <div className="searchable-movie-reviews">
        <form onSubmit={ this.onSubmitHandler }>
          <input 
            type="text" 
            placeholder="enter search term"
            onChange={ this.onChangeHandler }
          />
          <input type="submit" value="Submit" />
        </form>
        <MovieReviews reviews={ this.state.reviews } />
      </div>
    );
  }
}
