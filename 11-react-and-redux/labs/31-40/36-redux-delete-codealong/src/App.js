import React from 'react';
import CreateTodo from './components/todos/CreateTodo'
import Todos from './components/todos/Todos'

const App = (props) => {
  return (
    <div className="App">
      <CreateTodo store={ props.store } />
      <Todos store={ props.store } />
    </div>
  );
}

export default App;
