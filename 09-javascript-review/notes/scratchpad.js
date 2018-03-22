// practice

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


//////////////////////////////////////////////////////////////
// Traversing nested objects

const person = {
    name: "Awesome Name",
    occupation: {
        title: "Senior Manager of Awesome",
        yearsHeld: 2
    },
    pets: [{
        kind: "dog",
        name: "Fiona"
    }, {
        kind: "cat",
        name: "Ralph"
    }]
}

person['name'] // 'Awesome Name'
person['occupation']['yearsheld'] // 2
person['pets'][0]['name'] // 'Fiona'

person.name // 'Awesome Name'
person.occupation.yearsHeld // 2
person.pets[0].name // 'Fiona'


const collections = [1, [2, [4, [5, [6]], 3]]]

collections
//  [1, Array(2)]
collections[0]
// 1
collections[1]
//  [2, Array(3)]
collections[1][0]
// 2
collections[1][1]
// [4, Array(2), 3]
collections[1][1][0]
// 4
collections[1][1][1]
// [5, Array(1)]
collections[1][1][2]
//3
collections[1][1][1][0]
// 5
collections[1][1][1][1]
// [6]
collections[1][1][1][1][0]
// 6

