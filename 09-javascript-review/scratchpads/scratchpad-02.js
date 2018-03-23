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
