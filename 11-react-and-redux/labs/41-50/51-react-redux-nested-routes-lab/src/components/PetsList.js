import React from 'react';
import { Link } from 'react-router-dom';

const PetsList = ({ pets }) => {
  const renderPets = pets.map(pet => 
    <Link style={{ marginRight: '12px' }} key={pet.id} to={`/pets/${pet.id}`}>{pet.name}</Link>
  );
  
  return (
    <div>
      {renderPets}
    </div>
  );
};

export default PetsList;