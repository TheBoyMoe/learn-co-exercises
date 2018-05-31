import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Home from './Home';
import About from './About';
import Login from './Login';
import Navbar from './Navbar';

ReactDOM.render(
  <Router>
    <div>
      <Navbar />
      <Route path="/" component={Home} exact />
      <Route path="/about" component={About} />
      <Route path="/login" component={Login} />
    </div>
  </Router>,
  document.getElementById('root')
);
