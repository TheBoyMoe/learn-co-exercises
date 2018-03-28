// solutions
function Point(x, y) {
  this.x = x
  this.y = y
}

Point.prototype.toString = function () {
  return `Location ${this.x}, ${this.y}`
}

function Side(length) {
  this.length = length
}

/////// Shape
function Shape() {
  this.position = null
}

Shape.prototype.addToPlane = function (x, y) {
  this.position = new Point(x, y)
}

Shape.prototype.move = function (x, y) {
  this.position = new Point(x, y)
}

/////// Circle
function Circle(radius) {
  Shape.call(this)
  this.radius = radius
}

Circle.prototype = Object.create(Shape.prototype)
Circle.prototype.constructor = Circle

Circle.prototype.area = function () {
  return Math.PI * this.radius * this.radius
}

Circle.prototype.circumference = function () {
  return 2 * Math.PI * this.radius
}

Circle.prototype.diameter = function () {
  return this.radius * 2
}


//// Polygon
function Polygon(arrayOfSides) {
  Shape.call(this)
  this.sides = arrayOfSides
}

Polygon.prototype = Object.create(Shape.prototype)
Polygon.prototype.constructor = Polygon

Polygon.prototype.perimeter = function () {
  return this.sides.reduce((sum, side)=>{
     return sum + side.length
  }, 0)
}

Polygon.prototype.numberOfSides = function () {
  return this.sides.length
}


//// Quadrilateral
function Quadrilateral(sideOne, sideTwo, sideThree, sideFour) {
  Polygon.call(this, [
    new Side(sideOne),
    new Side(sideTwo),
    new Side(sideThree),
    new Side(sideFour)
  ])
  this.sideOne = sideOne
  this.sideTwo = sideTwo
  this.sideThree = sideThree
  this.sideFour = sideFour
}

Quadrilateral.prototype = Object.create(Polygon.prototype)
Quadrilateral.prototype.constructor = Quadrilateral


/// Triangle
function Triangle(sideOne, sideTwo, sideThree) {
  Polygon.call(this, [
    new Side(sideOne),
    new Side(sideTwo),
    new Side(sideThree)
  ])
  this.sideOne = sideOne
  this.sideTwo = sideTwo
  this.sideThree = sideThree
}

Triangle.prototype = Object.create(Polygon.prototype)
Triangle.prototype.constructor = Triangle


//// Rectangle
function Rectangle(width, height) {
  Quadrilateral.call(this, width, height, width, height)
  this.width = width
  this.height = height
}

Rectangle.prototype = Object.create(Quadrilateral.prototype)
Rectangle.prototype.constructor = Rectangle

Rectangle.prototype.area = function () {
  return this.width * this.height
}


//// Square
function Square(length) {
  Rectangle.call(this, length, length)
  this.length = length
}

Square.prototype = Object.create(Rectangle.prototype)
Square.prototype.constructor = Square

Square.prototype.listProperties = function () {
  let str = ""
  for (let prop in this) {
    if(this.hasOwnProperty(prop)) {
      str += `this.${prop} = ${this[prop]}\n`
    }
  }
}
