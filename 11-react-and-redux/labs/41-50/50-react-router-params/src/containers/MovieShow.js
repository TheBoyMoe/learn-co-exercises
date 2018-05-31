import React from 'react';
import { connect } from 'react-redux';

const MovieShow = ({ movie }) =>
  <div>
    <h3>Title: { movie.title }</h3>
  </div>;

// we can access any dynamic pieces of the URL via the ownProps.match.params obj
// assuming we find a movie, add it to the props
const mapStateToProps = (state, ownProps) => {
  const movie = state.movies.find(movie => movie.id == ownProps.match.params.movieId);
  if(movie) {
    return { movie }
  } else {
    return { movie: {} }
  }
};

export default connect(mapStateToProps)(MovieShow);
