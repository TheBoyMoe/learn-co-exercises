import React from 'react';
import CreateTodo from './components/todos/CreateTodo'

const App = (props) => {
  return (
    <div className="App">
      <CreateTodo store={props.store} />
    </div>
  );
}
export default App;
