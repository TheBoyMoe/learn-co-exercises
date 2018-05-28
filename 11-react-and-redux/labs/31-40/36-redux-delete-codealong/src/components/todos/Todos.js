import React from 'react'
import Todo from './Todo'

const Todos = (props) => {
  // pass store object to child component so we can delete item
  const todos = props.store.getState().todos.map((todo, i) => {
    return (
      <Todo 
        key={i}
        id={ todo.id }
        text={ todo.text }
        store={ props.store }
      />
    );
  });

  return(
    <ul>
      {todos}
    </ul>
  );
};

export default Todos;
