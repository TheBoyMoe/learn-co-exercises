import React from 'react';
import Todo from './Todo';

const Todos = (props) => {
  const todos = props.store.getState().todos.map((todo, i) => {
    return <Todo key={i} text={ todo.text } /> 
  });

  return(
    <ul>
      {todos}
    </ul>
  );
};

export default Todos;
