import React from 'react';
import BandInput from './components/BandInput';
import Bands from './components/Bands';

const App = (props) => {
  return (
    <div className="App">
      <BandInput store={ props.store } />
      <Bands store={ props.store }/>
    </div>
  );
};
export default App;
