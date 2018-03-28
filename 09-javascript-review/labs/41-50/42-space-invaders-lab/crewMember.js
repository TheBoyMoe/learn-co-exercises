class CrewMember {
  constructor(position, currentShip = 'Looking for a Rig'){
    this.position = position
    this.currentShip = currentShip
  }

  engageWarpDrive(){
    // this.checkForCrew()
    if(this.currentShip === "Looking for a Rig"){
      return "had no effect"
    }
    if(this.position === 'Pilot' && this.currentShip !== 'Looking for a Rig') {
      this.currentShip.warpDrive = 'engaged'
    }
  }

  setsInvisibility(){
    // this.checkForCrew()
    if(this.currentShip === "Looking for a Rig"){
      return "had no effect"
    }
    if(this.position === 'Defender' && this.currentShip !== 'Looking for a Rig'){
      this.currentShip.cloaked = true
    }
  }

  chargePhasers(){
    if(this.currentShip === "Looking for a Rig"){
      return "had no effect"
    }
    if(this.position === 'Gunner' && this.currentShip !== 'Looking for a Rig'){
      this.currentShip.phasersCharge = 'charged'
    }
  }

  checkForCrew(){
    if(this.currentShip === "Looking for a Rig"){
      return "had no effect"
    }
  }

}
