//////////////////////////////////
// First class functions
"use strict";

let liftWeights = ()=>{
	return 'just popped a sweat pumping iron!'
}

let swimFortyLaps =()=>{
	return 'just swam the channel'
}

let exerciseRoutine = (exercise)=>{
  return exercise()
}

let morningRoutine = (exercise)=>{
	let breakfast = null;
	if(exercise === liftWeights){
	  breakfast = "protein shake"
  } else if(exercise === swimFortyLaps){
	  breakfast = 'bowl of pasta'
  } else {
    breakfast = 'mc donalds'
  }

  let result = exerciseRoutine(exercise)

  return ()=>{
    return `Mom, mom, mom, I ${result} and had a ${breakfast} for breakfast!`
  }
}

morningRoutine(liftWeights)()

////////////////////////////////////////
// Closures

let whatsForTea = (item)=>{
  let checkItem = ()=>{
    return (item === 'chocolate')? 'I love chocolate': (item === 'pancakes')? 'hhhmmm pancakes with syrup': (!item)? 'Someone stole my food' : `I hate ${item}, where's my food!!!!`
  }

  let stealItem = ()=> item = null

  return {
    checkItem,
    stealItem
  }
}

let result = whatsForTea('chocolate')
result.checkItem()
result["checkItem"]()

// using es6 object destructuring, variable name MUST match method names
let {checkItem, stoleItem} = whatsForTea('pancakes')
checkItem()
stoleItem()