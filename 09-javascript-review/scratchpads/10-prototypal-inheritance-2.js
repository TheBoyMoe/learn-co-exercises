function Shape(sides, x, y) {
  this.sides = sides
  this.x = x
  this.y = y
}

// if we extend the behaviour of Shape
Shape.prototype.move = function (x, y) {
  this.x = x
  this.y = y
}

Shape.prototype.position = function () {
  return `${this.x}, ${this.y}`
}


function Quadrilateral(x, y, sideOneLength, sideTwoLength, sideThreeLength, sideFourLength) {
  // call Shape constructor
  Shape.call(this, 4, x, y); // Shape(sides, x, y)
  this.sideOneLength = sideOneLength;
  this.sideTwoLength = sideTwoLength;
  this.sideThreeLength = sideThreeLength;
  this.sideFourLength = sideFourLength;
}

Quadrilateral.prototype = Object.create(Shape.prototype)
Quadrilateral.prototype.constructor = Quadrilateral

//extend Quadrilateral
Quadrilateral.prototype.perimeter = function() {
  return this.sideOneLength + this.sideTwoLength + this.sideThreeLength + this.sideFourLength;
}

function Rectangle(x, y, width, height) {
  Quadrilateral.call(this, x, y, width, height, width, height)
  this.width = width
  this.height = height
}

Rectangle.prototype = Object.create(Quadrilateral.prototype)
Rectangle.prototype.constructor = Rectangle

// extend the polygon behaviour
Rectangle.prototype.area = function () {
  return this.width * this.height
}

function Square(x, y, length) {
  Rectangle.call(this, x, y, length, length)
  this.length = length
}

Square.prototype = Object.create(Rectangle.prototype)
Square.prototype.constructor = Square

square = new Square(1,1,3)

square.length; // 3 - defined on Square

square.width; // 3 - inherited from Rectangle

square.sideOneLength; // 3 - inherited from Quadrilateral through Rectangle

square.position(); // 1,1 - from Shape

square.move(2,3); // from Shape
square.position(); // 2,3

square.area(); // 9 - from Rectangle
square.perimeter(); // 12 - from Quadrilateral