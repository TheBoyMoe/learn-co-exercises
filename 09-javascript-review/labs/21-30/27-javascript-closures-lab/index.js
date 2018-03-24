// solutions
"use strict";

function bumpCounter() {
  let counter = 0

  let addBump = ()=>{
    counter++
  }

  let getBumps = ()=>{
    return counter;
  }


  return {
    addBump,
    getBumps
  }
}


function createAnimal(animalType) {

  return (deadlyDevice)=>{
    return {animalType: animalType, deadlyDevice: deadlyDevice}
  }
}

var sharkCreator = createAnimal('Shark')
var sharkWithFrickinLaserbeam = sharkCreator('Laserbeam')
var sharkWithFrickinCannon = sharkCreator('Cannon')
