import React from 'react';

const Review = (review, i) => {
	return (
    <div key={i} className="review">
      <h2>{ review.display_title }, by { review.byline }</h2>
      <h3>{ review.headline }</h3>
      <p>{ review.summary_short }</p>
    </div>
	);
}

const MovieReviews = (props) => {
  return (
    <div className="review-list">
      { props.reviews.map(Review) }
    </div>
  );
}

MovieReviews.defaultProps = {
  reviews: []
}

export default MovieReviews;
