"use strict";

// custom map method that abstracts a for loop
function map(collection, callback) {
  const result = []
  for(let i = 0, l = collection.length; i < l; i++){
    result.push(callback(collection[i], i, collection))
  }
  return result
}

const transformedBots = (autobot)=>{
  //create a copy of the objects so the original array is unchanged
  return Object.assign({}, autobot, {
    strength: autobot.strength * 2,
    isTransformed: true
  })
}

const autobots = [
  { name: 'Optimus Prime', strength: 5, isTransformed: false, },
  { name: 'Ironhide', strength: 3, isTransformed: false, },
  { name: 'Bumblebee', strength: 2.5, isTransformed: false, },
  { name: 'Ratchet', strength: 1.5, isTransformed: false, },
];

map(autobots, transformedBots)
/*
  [
    {name: "Optimus Prime", strength: 10, isTransformed: true},
    {name: "Ironhide", strength: 6, isTransformed: true},
    {name: "Bumblebee", strength: 5, isTransformed: true},
    {name: "Ratchet", strength: 3, isTransformed: true}
  ]
*/