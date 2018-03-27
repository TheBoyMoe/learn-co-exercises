// POJO
let plainSandwich = {
  bread: 'Malt',
  ingredients: ['peanut butter', 'jelly'],
  cut: 'doorstep',
  name: 'Peanut Butter and Jelly',
  serve: function(){
    return `Here's your "${this.name}" enjoy!`
  }
}

plainSandwich.serve()
//=> "Here's your "Peanut Butter and Jelly" enjoy!"

// using a function constructor
function Sandwich(bread, ingredients, cut) {
  this.bread = bread
  this.ingredients = ingredients
  this.cut = cut
  this.serve = function () {
    return `Here's your '${this.name}' enjoy!`
  }
}

sarni = new Sandwich('rye', ['ham', 'cheese'], 'doorstep')
sarni.serve()
//=> "Here's your 'undefined' enjoy!" // Sandwich does not have a 'name' property
sarni.name = "ham and cheese on rye"
sarni.serve()
//=> "Here's your 'ham and cheese on rye' enjoy!"


// create a serve() function that can be used with other objects
function serve() {
  return `Here's your '${this.name}' enjoy!`
}

function Bread(name, ingredients, size){
  this.name = name
  this.ingredients = ingredients
  this.size = size
}

function Dog(name, breed, age){
  this.name = name
  this.breed = breed
  this.age = age
}

rye = new Bread('Rye bread', ['rye flour', 'yeast'], 'large')
max = new Dog('Max', 'Alsatian', 4)

// using javascript's call() function - invoke the call() method of the serve function
serve.call(rye) //=> "Here's your 'Rye bread' enjoy!"
serve.call(max) //=> "Here's your 'Max' enjoy!"
serve.call(sarni) //> "Here's your 'undefined' enjoy!"

// using apply()
serve.apply(rye) //=> "Here's your 'Rye bread' enjoy!"
serve.apply(max) //=> "Here's your 'Max' enjoy!"


// passing arguments to call() abd apply()
function serveWithArgs(customer) {
  return `Hey ${customer}, here's your ${this.name}`
}

serveWithArgs.call(rye, 'Tony')
//=> "Hey Tony, here's your Rye bread"

serveWithArgs.call(max, 'John')
//=> "Hey John, here's your Max"

serveWithArgs.apply(rye, ['Tony'])
//=> "Hey Tony, here's your Rye bread"

serveWithArgs.apply(max, ['John'])
//=> "Hey John, here's your Max"

function serveWithMoreArgs(customer, table, time) {
  return `Hey ${customer}, we've reserved table ${table} for you at ${time}, here's your ${this.name}`
}


serveWithMoreArgs.call(rye,'John', 5, '7.00')
//=> "Hey John, we've reserved table 5 for you at 7.00, here's your Rye bread"

serveWithMoreArgs.apply(rye, ['john', 3, '3.00'])
//=> "Hey john, we've reserved table 3 for you at 3.00, here's your Rye bread"



// Using call() and apply() with variadic functions
function deliverFood() {
  if(arguments.length > 0){
    // arguments is an array 'like' obj, 'borrow' slice method to create an array copy
    let customers = Array.prototype.slice.call(arguments)
    let last = customers.pop();
    return `${this.name} for ${customers.join(', ')} and ${last}. Enjoy!`
  } else {
    return `${this.name}. Enjoy!`
  }
}

deliverFood.apply(rye, ['john', 'Tony', 'Max'])
//=> "Rye bread for john, Tony and Max. Enjoy!"
deliverFood.apply(rye)
//=> "Rye bread. Enjoy!"
deliverFood.apply(rye, ['John'])
//=>"Rye bread for  and John. Enjoy!"
deliverFood.call(rye, 'john', 'tony', 'max')
//=> "Rye bread for john, tony and max. Enjoy!"
deliverFood.call(rye)
//=> "Rye bread. Enjoy!"


/// Borrowing functions from other objects with bind()
function SandwichMaker(bread, ingredients, name) {
  this.bread = bread;
  this.ingredients = ingredients;
  this.name = name;
  this.describe = function() {
    console.log("Your " + this.name + " includes: " + this.ingredients.join(", ") + ". Yum!");
  }
  this.deliver = function(staff, table){
    return `Hey ${staff}, take the ${this.name} over to table ${table}`
  }
}

var sandwich = new SandwichMaker('Rye', ['ham', 'cheese', 'pickel', 'mayo'], 'Ham and Cheese on Rye')
sandwich.describe()
//=> "Your Ham and Cheese on Rye includes: ham, cheese, pickel, mayo. Yum!"
sandwich.deliver('Tony', 4)
//=> "Hey Tony, take the Chicken n Pickel on Rye over to table 4"


var salad = {
  name: 'Mixed salad',
  ingredients: ['lettuce', 'tomato', 'cucumber'],
  cost: 2.34
}

//=> Your Mixed salad includes: lettuce, tomatoe, cucumber. Yum!
// which we can call at a later date
// we can borrow the 'describe()' method - creates a new function
// passing any additional args when the function is bound or later when called
salad.describe = sandwich.describe.bind(salad)
salad.describe()

salad.deliver = sandwich.deliver.bind(salad, 'Tom', 8)
salad.deliver()
//=> "Hey Tom, take the Mixed salad over to table 8"

salad.deliver = sandwich.deliver.bind(salad)
salad.deliver('Roger', 2)
//=> "Hey Roger, take the Mixed salad over to table 2"






