import React from 'react';

const Bands = (props) => {
  const bands = props.store.getState().bands.map((band, i) => {
    return <li key={i}>{ band }</li>
  });

  return (
    <ul>{ bands }</ul>
  );
};

export default Bands;
