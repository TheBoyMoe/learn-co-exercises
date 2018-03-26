//// use of 'this'

var chair = {
  style: 'classical',
  age: 124,
  material: 'wood',
  f: function () {
    console.log(this)
    return `${this}`
  }
}

// with/without "use strict"
chair.f()
//=> {style: "classical", age: 124, material: "wood", f: ƒ}
//=> "[object Object]"


function Animal(species, weight, age){
  "use strict";
  this.species = species
  this.weight = weight
  this.age = age
  this.f = function () {
    console.log(this)
    return `${this}`
  }
}

dog = new Animal('Dog', '34.4kg', 3)
// with/without "use strict"
dog.f() //=>
// Animal {species: "Dog", weight: "34.4kg", age: 3, f: ƒ}
// "[object Object]"


function checkThis(){
  "use strict";
  console.log(this)
  return `${this}`
}

checkThis() //=>
// undefined
// "undefined"


// Without "use strict"
function checkThisAgain(){
  console.log(this)
  return `${this}`
}

// In 'sloppy mode' the function's "this" property refers to the global object
checkThisAgain() //=>
// Window {postMessage: ƒ, blur: ƒ, focus: ƒ, close: ƒ, frames: Window, …}
// "[object Window]"


// We can also make use of 'this' we DOM events

```
<img class="pix" src="">
<img class="pix" src="">
<img class="pix" src="">
<img class="pix" src="">
```

let imgs = document.getElementsByClassName('pix')
for(let i = 0, l = imgs.length; i < l; i++){
  imgs[i].addEventListener('click', callback, false)
}

function callback(e) {
  // refers to the img clicked on - we can use that fact to manipulate it
  console.log(this)
}
