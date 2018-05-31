import React from 'react';
import { BrowserRouter as Router, NavLink, Route } from 'react-router-dom';
import PetsPage from '../containers/PetsPage';

const App = (props) => 
  <Router>
    <div>
      <div style={{ borderBottom: '2px solid black', paddingBottom: '10px', marginBottom: '12px' }}>
        <NavLink style={{ marginRight: '10px' }} to="/pets">See All The Pets!</NavLink>
        <NavLink style={{ marginRight: '10px' }} to="/pets/new">Add A Pet</NavLink>
      </div>
      <Route exact path="/" render={() => <h3>Welcome to the Pets List App</h3>} />
      <Route path="/pets" component={PetsPage} />
    </div>
  </Router>;

export default App;