import React from 'react';

import Filters from './Filters';
import PetBrowser from './PetBrowser';

export default class App extends React.Component {
  constructor() {
    super();

    this.state = {
      pets: [],
      adoptedPets: [],
      filters: {
        type: 'all',
      }
    };
  }

  onChangeTypeHandler = (value) => {
    this.setState({
      filters: {
        ...this.state.filters,
        type: value
      }
    });
  };

  onFindPetsHandler = () => {
    const type = this.state.filters.type;
    let url = '';
    switch(type){
      case 'cat':
        url = '/api/pets?type=cat';
        break;
      case 'micropig':
        url = '/api/pets?type=micropig';
        break;
      case 'dog':
        url = '/api/pets?type=dog';
        break;
      default:
        url = '/api/pets';
        break;
    }
    fetch(url)
      .then(res => res.json)
      .then(pets => this.setState({ pets }))
  };

  onAdoptPetHandler = (id) => {
    this.setState({
      adoptedPets: [...this.state.adoptedPets, id]
    }); 
  };

  render() {
    return (
      <div className="ui container">
        <header>
          <h1 className="ui dividing header">React Animal Shelter</h1>
        </header>
        <div className="ui container">
          <div className="ui grid">
            <div className="four wide column">
              <Filters 
                filters={ this.state.filters }
                onChangeType={ this.onChangeTypeHandler }
                onFindPetsClick={ this.onFindPetsHandler }
              />
            </div>
            <div className="twelve wide column">
              <PetBrowser 
                pets={ this.state.pets }
                onAdoptPet={ this.onAdoptPetHandler }
                adoptedPets={ this.state.adoptedPets }
              />
            </div>
          </div>
        </div>
      </div>
    );
  }
}

