var cart = [];

function getCart() {
 return cart;
}

function setCart(c) {
  cart = c;
  return cart;
}

function addToCart(item) {
  cart = getCart()
  cart.push({itemName: item, itemPrice: Math.random() * 100 + 1})
    return `${item} has been added to your cart.`
}

function viewCart() {
    if (getCart().length < 1) {
        return "Your shopping cart is empty."
    } else {
        return printCart(getCart())
    }
}

function total() {
  cart = getCart()
  var sum = 0
  for(let i = 0; i < cart.length; i++){
      sum += cart[i].itemPrice
  }
  return sum
}

function removeFromCart(item) {
  cart = getCart()
  var index = null, i = 0
  while(i < cart.length){
    if (cart[i].itemName == item){
      index = i
      break;
    }
    i++
  }
  if (index) {
      cart.splice(index, 1)
  } else {
      return "That item is not in your cart."
  }
}

function placeOrder(cardNumber) {
    if (!cardNumber) {
        return "Sorry, we don't have a credit card on file for you."
    }
    var message = `Your total cost is $${total()}, which will be charged to the card ${cardNumber}.`
    setCart([])
    return message
}

function printCart(cart) {
    if (cart.length < 2){
        return `In your cart, you have ${cart[0].itemName} at $${cart[0].itemPrice}.`
    } else {
        var str = "In your cart, you have"
        for(let i = 0; i < cart.length - 1; i++){
            str += ` ${cart[i].itemName} at $${cart[i].itemPrice},`
        }
        str += ` and ${cart[cart.length - 1].itemName} at $${cart[cart.length - 1].itemPrice}.`
        return str
    }
}