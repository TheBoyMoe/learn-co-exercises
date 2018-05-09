class Driver {
  constructor(name, date){
    this.name = name;
    this.startDate = new Date(date);
  }

  yearsExperienceFromBeginningOf(endDate){
    return endDate - this.startDate.getFullYear();
  }
}

class Route {
  constructor(beginningLocation, endingLocation){
    this.beginningLocation = beginningLocation;
    this.endingLocation = endingLocation;
  }

  blocksTravelled(){
    const eastWest = ['1st Avenue', '2nd Avenue', '3rd Avenue', 'Lexington Avenue', 'Park', 'Madison Avenue', '5th Avenue'];
    const ew = Math.abs(eastWest.indexOf(this.endingLocation.horizontal) - eastWest.indexOf(this.beginningLocation.horizontal));
    const ns = Math.abs(this.endingLocation.vertical - this.beginningLocation.vertical);
    return ew + ns;
  }

  estimatedTime(peak){
    return (peak)? this.blocksTravelled()/2 : this.blocksTravelled()/3;
  }
}
