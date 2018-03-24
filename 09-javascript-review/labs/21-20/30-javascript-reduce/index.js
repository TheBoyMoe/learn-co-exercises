"use strict";

const products = [
  { name: 'Head & Shoulders Shampoo', price: 4.99, discount: .6 },
  { name: 'Twinkies', price: 7.99, discount: .45 },
  { name: 'Oreos', price: 6.49, discount: .8 },
  { name: 'Jasmine-scented bath pearls', price: 13.99, discount: .7 }
];

function getTotalPriceOfProductsThatQualify(products) {
  let total = 0
  products.forEach((product)=>{
    if(product.discount >= 0.5){
      total += product.price
    }
  })
  return total
}

// If we wanted to sum the total price of all products < 7.0, we'd need another function
// instead, we can pass in a function as the second argument that handles this logic
// 'outer' function handles the iteration, callback function handles the 'business' logic
function getTotalAmountForProducts(products, callback){
  let totalPrice = 0
  products.forEach((product)=>{
    totalPrice = callback(totalPrice, product)
  })
  return totalPrice
}

// the callback's logic depending on the property we want to check
var callback = (totalPrice, product)=>{
  if(product.discount >= 0.5){
    return totalPrice + product.price
  }
}

callback = (totalPrice, product)=>{
  if(product.price < 7.0){
    return totalPrice + product.price
  }
}


// We can also pass in an initial value
function getTotalAmount(products, callback, initialValue){
  let totalPrice = initialValue
  products.forEach((product)=>{
    totalPrice = callback(totalPrice, product)
  })
  return totalPrice
}

// To make our function more generic - we need to define the logic the callback implements
function reduce(collection, callback, initialValue) {
  let result = initialValue
  collection.forEach((item, index, collection)=>{
    result = callback(result, item, index, collection)
  })

  return result
}

// TEST
const couponLocations = [
  { room: 'Living room', amount: 5 },
  { room: 'Kitchen', amount: 2 },
  { room: 'Bathroom', amount: 1 },
  { room: 'Master bedroom', amount: 7 }
];

// totalAmount === result, location === item
function couponCounterCallback(totalAmount, location) {
  return totalAmount + location.amount
}

reduce(couponLocations, couponCounterCallback, 0)
reduce(couponLocations, couponCounterCallback, 3)

// using the reduce() method in the JS library
couponLocations.reduce(couponCounterCallback, 0)


