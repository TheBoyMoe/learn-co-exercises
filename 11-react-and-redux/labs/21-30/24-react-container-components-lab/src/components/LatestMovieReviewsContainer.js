import React from 'react';
import MovieReviews from './MovieReviews';
require('isomorphic-fetch');
require('es6-promise').polyfill();


const NYT_API_KEY = '91acd1323e694da8b4548f80a4f8ffc8';
const URL = 'https://api.nytimes.com/svc/movies/v2/reviews/all.json?'
            + `api-key=${NYT_API_KEY}`;

export default class LatestMovieReviewsContainer extends React.Component {

  constructor(){
    super();
    this.state = {
      reviews: []
    };
  }

  // fetch data and update state
  componentWillMount = () => {
    // https://github.com/matthew-andrews/isomorphic-fetch
    fetch(URL)
      .then((res) => {
        if(res.status >= 400)
          throw new Error("Error occured");
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
      <div className="latest-movie-reviews">
        <h1>Latest Movie Listing</h1>
        <MovieReviews reviews={ this.state.reviews } />
      </div>
    );
  };
}
