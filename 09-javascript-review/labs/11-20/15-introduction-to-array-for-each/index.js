// Add your doToElementsInArray() function here:
var doToElementsInArray = (array, callback) => {
  array.forEach(callback)
}

// Add your changeCompletely() function here:
var changeCompletely = (e, i, array) => {
  array[i] = `${e}!!!!`
}
