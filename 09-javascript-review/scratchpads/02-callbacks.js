//////////////////////////////////
// First class functions
"use strict";

// using callbacks

var callback = (n,i)=>{
  if (n == 1){
    return `found a match, index ${i}`
  } else {
    return n * n
  }
}

var findOne = (array)=>{
  return array.map(callback)
}

findOne([2,3,4,1,5,6,7,8])

///////////////////////////////////////////////////////////////

var matcher = (e, v)=>{
  if (e == v) return true
}

var findMatch = (array, value, callback)=>{
  debugger
  for(let i = 0; i < array.length; i++){
    if(callback(array[i], value)) return i
  }
  return false
}


////////////////////////////////////////////////////////////

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