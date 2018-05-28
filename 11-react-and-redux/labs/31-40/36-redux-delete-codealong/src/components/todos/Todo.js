import React from 'react';

const Todo = (props) => {

  function onClickHandler() {
    console.log('clicked item');
    props.store.dispatch({
      type: 'DELETE_TODO',
      id: props.id
    });
  };

  return (
    <li>
      { props.text }
      <button onClick={ onClickHandler }>Delete</button>
    </li>
  );
};

export default Todo
