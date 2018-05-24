import React, { Component } from 'react'
import { getRandomColor, getReducedColor } from './randomColorGenerator.js'
import Tier3 from './Tier3'


export default class Tier2 extends Component {

  constructor(props) {
    super(props)
    this.state = {
      childColor: getReducedColor(this.props.color),
    }
  }

  // results in Tier3 components updating color when clicking on Tier 2
  componentWillReceiveProps = (nextProps) => {
    this.setState({
      childColor: getReducedColor(nextProps.color)
    });
  };

  updateChildColor = (e) => {
    e.stopPropagation();
    this.setState({
      childColor: getRandomColor() 
    });
  }

  render() {
    // hard coded color values have been added below, though they won't be
    // present in our solution. What should they be replaced with?
    return (
      <div 
        className="tier2" 
        style={{backgroundColor: this.props.color, color: this.props.color}}
        onClick={ this.props.handleChildClick }
      >
        <Tier3 
          color={ this.state.childColor } 
          handleChildClick={ this.updateChildColor }
        />
        <Tier3 
          color={ this.state.childColor } 
          handleChildClick={ this.updateChildColor }
        />
      </div>
    )
  }
}
