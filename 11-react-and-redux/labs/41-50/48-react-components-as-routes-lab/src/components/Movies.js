import React from 'react';
import { movies } from '../data';

const Movies = () => {
  return (
    <div>
      <h1>Movies Page</h1>
        { movies.map((movie, i) => {
          return (
            <div key={i} className="movies">
              <p>{movie.title}, time: {movie.time}</p>
              <ul>
                {movie.genres.map((genre, i) => <li key={i}>{genre}</li>)}
              </ul>
            </div>
          )
        })}
    </div>
  );
};

export default Movies;
