// solution

// iterable - the object we'll iterate over - array/object(type-check on the fly)
// callback - the function that will perform the iteration
function forEach(iterable, callback) {
  if(Array.isArray(iterable)){
    // behave like Array.prototype.forEach - the the elm, i and array to the callback
    for(let i = 0, l = iterable.length; i < l; i++){
      callback(iterable[i], i, iterable)
    }
  } else if(typeof iterable === 'object'){
    for(const key in iterable) {
      if(iterable.hasOwnProperty(key)){
        callback(iterable[key], key, iterable)
      }
    }
  }
}
