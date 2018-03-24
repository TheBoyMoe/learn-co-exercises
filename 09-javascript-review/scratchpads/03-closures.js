////////////////////////////////////////
// Closures

let whatsForTea = (item)=>{
  let checkItem = ()=>{
    return (item === 'chocolate')? 'I love chocolate': (item === 'pancakes')? 'hhhmmm pancakes with syrup': (!item)? 'Someone stole my food' : `I hate ${item}, where's my food!!!!`
  }

  let stealItem = ()=> item = null

  return {
    checkItem,
    stealItem
  }
}

let result = whatsForTea('chocolate')
result.checkItem()
result["checkItem"]()

// using es6 object destructuring, variable name MUST match method names
let {checkItem, stoleItem} = whatsForTea('pancakes')
checkItem()
stoleItem()