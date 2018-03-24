
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
