import React from 'react';
import ReactDOM from 'react-dom';

import Survey from './components/Survey';
import Circles from './components/Circles';
import Pikachu from './components/Pikachu';
import Animation from './components/Animation';
import './style.css';

ReactDOM.render(
  <div>
    <div className="container">
      <div className="title">componentWillReceiveProps()</div>
      <Survey />
    </div>
    <div className="container">
      <div className="title">shouldComponentUpdate()</div>
      <Circles />
    </div>
    <div className="container">
      <div className="title">componentWillUpdate()</div>
      <Animation />
    </div>
    <div className="container">
      <div className="title">componentDidUpdate()</div>
      <Pikachu />
    </div>
  </div>,
  document.getElementById('global')
);
