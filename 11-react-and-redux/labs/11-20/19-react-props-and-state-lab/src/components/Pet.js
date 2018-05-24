import React from 'react';

export default class Pet extends React.Component {
  constructor() {
    super();
  }

  onClickHandler = () => this.props.onAdoptPet(this.props.pet.id);

  render() {
    return (
      <div className="card">
        <div className="content">
          <a className="header">
            { this.props.pet.name }
            (gender: { this.props.pet.gender === 'male'? '♂' : '♀'})
          </a>
          <div className="meta">
            <span className="date">{ this.props.pet.type }</span>
          </div>
          <div className="description">
            <p>Age: { this.props.pet.age }</p>
            <p>Weight: { this.props.pet.weight }</p>
          </div>
        </div>
        <div className="extra content">
          {
            this.props.isAdopted ?
              <button className="ui disabled button">Already adopted</button> :
              <button onClick={ this.onClickHandler } className="ui primary button">Adopt pet</button>
          }
        </div>
      </div>
    );
  }
}

