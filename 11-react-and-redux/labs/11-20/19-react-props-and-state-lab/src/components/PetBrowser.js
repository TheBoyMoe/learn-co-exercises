import React from 'react';

import Pet from './Pet';

export default class PetBrowser extends React.Component {

  render() {
    return (
      <div className="ui cards">
        {
          this.props.pets.map((pet) => 
            <Pet 
              pet={ pet }
              key={ pet.id }
              onAdoptPet={ this.props.onAdoptPet }
              isAdopted={ this.props.adoptedPets.includes(pet.id) }
            />
          )
        }
      </div>
    );
  }
}

