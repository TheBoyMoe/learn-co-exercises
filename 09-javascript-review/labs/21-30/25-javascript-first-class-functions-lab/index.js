// solution
"use strict";

// exercise 1
var countdown = (callback)=>{
  setTimeout(callback, 2000)
}

// exercise 2
var createMultiplier = (multiplierValue)=>{
  return (number)=>{
    return number * multiplierValue
  }
}

var doubler = createMultiplier(2)
var tripler = createMultiplier(3)

// exercise 3
var multiplier = (multiplierValue, value)=>{
  return multiplierValue * value
}


var doublerWithBind = multiplier.bind(null, 2)
var triplerWithBind = multiplier.bind(null, 3)
