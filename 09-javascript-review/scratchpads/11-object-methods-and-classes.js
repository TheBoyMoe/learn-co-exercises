"use strict";

// one way - every instantiated user object will have a copy of the method
function User(name, email){
  this.name = name
  this.email = email
  this.sayHello = function () {
    return `Hello, my name is ${this.name}`
  }
}

// use
let user = new User('Johnny Cash', 'John.cash@ex.com')
user.sayHello()

// better way is to use prototype
function Animal(species, weight, age) {
  this.species = species
  this.weight = weight
  this.age = age
}

Animal.prototype.description  = function () {
  return `${this.age} yr old ${this.species} with a weight of ${this.weight}`
}


// ES6 added Classes to js (not true classes, just an abstraction added on top of prototypal object creation)
class Person {
  constructor(name, email){
    this.name = name
    this.email = email
  }

  // methods are defined on the objects prototype, e.g. Person.prototype.sayHello
  sayHello(){
    return `Hello, my name is ${this.name}`
  }
}

// use
let person = new Person('Johnny Cash', 'John.cash@ex.com')
person.sayHello()


// Inheritance with ES6 classes
class Employee extends Person {

  // override sayHello()
  sayHello() {
    return `${super.sayHello()}, i am an employee`
  }
}

let employee = new Employee('Tom', 'tom@ex.com')
employee.sayHello()
//=> "Hello, my name is Tom, i am an employee"


class Manager extends Employee {

  constructor(name, email, grade){
    super(name, email)
    this.grade = grade
  }

  sayHello() {
    return `${super.sayHello()}, i'm a manager`
  }

  description(){
    return `I'm ${this.name}, a ${this.grade}`
  }
}

let manager = new Manager('pete', 'pete@ex.com', 'Business consultant')
manager.sayHello()
// => "Hello, my name is pete, i am an employee, i'm a manager"
