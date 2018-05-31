import React from 'react';
import { directors } from '../data';

const Directors = () => {
  return (
    <div>
      <h1>Directors Page</h1>
      { directors.map((director, i) => {
        return (
          <div key={i} className="director">
            <p>{ director.name}</p>
            <ul>
              { director.movies.map((movie, i)=> <li key={i}>{movie}</li>)}
            </ul>
          </div>
        )
      })}
    </div>
  );
}

export default Directors
