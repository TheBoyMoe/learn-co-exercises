import React from 'react';

class Filters extends React.Component {
  constructor() {
    super();
  }

  onChangeHandler = (e) => this.props.onChangeType(e.target.value);
  onClickHandler = () => this.props.onFindPetsClick();

  render() {
    return (
      <div className="ui form">
        <h3>Animal type</h3>
        <div className="field">
          <select 
            name="type" 
            id="type"
            value={ this.props.filters.type }
            onChange={ this.onChangeHandler }
          >
            <option value="all">All</option>
            <option value="cat">Cats</option>
            <option value="dog">Dogs</option>
            <option value="micropig">Micropigs</option>
          </select>
        </div>

        <div className="field">
          <button 
            className="ui secondary button"
            onClick={ this.onClickHandler }
          >Find pets</button>
        </div>
      </div>
    );
  }
}

export default Filters;
