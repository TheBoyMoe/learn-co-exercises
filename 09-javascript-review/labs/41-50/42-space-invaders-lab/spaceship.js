class Spaceship {
  constructor(name, crew, phasers, shields){
    this.name = name
    this.crew = crew
    this.phasers = phasers
    this.shields = shields
    this.cloaked = false
    this.warpDrive = 'disengaged'
    this.docked = (this.crew.length < 1)
    this.phasersCharge = 'uncharged'
    this.notifyCrewMembers()
  }

  notifyCrewMembers(){
    this.crew.forEach((crewMember)=>{
      crewMember.currentShip = this
    })
  }
}
