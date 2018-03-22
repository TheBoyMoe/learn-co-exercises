// solution

var iterativeLog = (array)=>{
  array.forEach((e, i)=>{
    console.log(`${i}: ${e}`)
  })
}

var iterate = (callback)=>{
  var arr = [1,2,3,4,5,6]
  arr.forEach(callback)
  return arr
}

var doToArray = (array, callback)=>{
  array.forEach(callback)
}

