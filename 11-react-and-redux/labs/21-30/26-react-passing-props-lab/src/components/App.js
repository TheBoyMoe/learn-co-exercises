import React from 'react';
import FruitBasket from './FruitBasket';

export default class App extends React.Component {
  constructor(){
    super();
    this.state = {
      fruit: [],
      filters: [],
      currentFilter: null
    };
  }

  componentDidMount() {
		this.fetchFruit();
		this.fetchFilters();
  }

  fetchFilters = () => {
    fetch('/api/fruit_types')
      .then(response => response.json())
      .then(filters => this.setState({ filters }));
  }

	fetchFruit = () => {
    fetch('/api/fruit')
      .then(response => response.json())
      .then(items => this.setState({ fruit: items }));
	}


  updateFilter = (event) => {
    console.log('change filter: ', event.target.value);
    this.setState({ currentFilter: event.target.value });
  }

  render(){
    return (
      <FruitBasket 
				fruit={ this.state.fruit }
				filters={ this.state.filters }
				currentFilter={ this.state.currentFilter }
				updateFilterCallback={ this.updateFilter }	
			/>
    );
  };
};

