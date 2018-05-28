import React from 'react';

const Todo = (props) => {
  return(
    <div>
      <li>{ props.text }</li>
    </div>
  );
};

export default Todo;
