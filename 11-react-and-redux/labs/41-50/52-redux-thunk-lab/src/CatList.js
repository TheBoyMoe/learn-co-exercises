import React from 'react';

const CatList = (props) => {
  const renderCats = props.catPics.map((cat, i) => 
    <li key={i} style={{width: '200px', marginRight: '10px'}}>
      <img src={ cat.url } style={{ width: '100%'}} alt="cat"/>
    </li>
  );

  return (
    <div>
      <ul>
        { renderCats }
      </ul>
    </div>
  );
};

export default CatList;
