import React from 'react';
import { actors } from '../data';

const Actors = () => {
  return (
    <div>
      <h1>Actors Page</h1>
      { actors.map((actor, i) => {
        return (
          <div key={i} className="actor">
            <p>{ actor.name }</p>
            <ul>
              {actor.movies.map((movie, i) => <li key={i}>{movie}</li>)}
            </ul>
          </div>
        )
      })}
    </div>
  );
};

export default Actors;
