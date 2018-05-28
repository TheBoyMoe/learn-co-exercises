// implement APP component
import React from 'react';
import Counter from './components/Counter';

const App = (props) => {
  return (
    <div className="App" >
      <Counter store={ props.store } />
    </div>
  );
}
export default App;
