// practice

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
