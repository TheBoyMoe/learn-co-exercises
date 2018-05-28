// implement Counter component
import React from 'react'

const Counter = (props) => {
  const handleOnClickIncrease = () => {
    props.store.dispatch({ type: 'INCREASE_COUNT' });
  };

  const handleOnClickDecrease = () => {
    props.store.dispatch({ type: 'DECREASE_COUNT' });
  }

  return (
    <div>
      <div>{ props.store.getState().count }</div>
      <button onClick={ handleOnClickIncrease }>Increase</button>
      <button onClick={ handleOnClickDecrease }>Decrease</button>
    </div>
  )
};
export default Counter;
