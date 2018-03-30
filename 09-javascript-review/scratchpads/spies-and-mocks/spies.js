"use strict";

function createStore() {
  const listeners = [];
  const data = {};

  function emitChange() {
    listeners.forEach(listener => listener());
  }

  function subscribe(callback) {
    listeners.push(callback);
  }

  function setData(key, value) {
    data[key] = value;
    emitChange();
  }

  function getData() {
    return data;
  }

  return {
    subscribe,
    setData,
    getData,
  };
}

const store = createStore()
store.subscribe(()=>{
  console.log(`Updated store data: ${store.getData()}`)
})

store.setData('flavour', 'Chocolate')


// Spying on existing functions

function sayHello(name) {
  console.log(`Hello, ${name}!`);
}

function welcomePersonAtTheDoor(person) {
  door.open();
  sayHello(person.firstName);
  door.close();
}