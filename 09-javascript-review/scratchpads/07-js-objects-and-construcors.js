
// create an object using object literal
var sandwich = {
  bread: 'white',
  filling: 'chicken',
  mayo: true,
  mustard: false,
  cheese: 'Swiss',
  veggies: 'Lettuce, Tomato and Cucumber'
}

// create an object using function constructor
function Sandwich(bread, filling, mayo, mustard, cheese, veggies){
  this.bread = bread
  this.filling = filling
  this.mayo = mayo
  this.mustard = mustard
  this.cheese = cheese
  this.veggies = veggies
}

// instantiate a sandwich object
let hamSandwich = new Sandwich('white', 'ham', true, false, 'Monterey Jack', 'lettuce')