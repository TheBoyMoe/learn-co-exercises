// Write your solution in this file!
const driver = {};

function updateDriverWithKeyAndValue(obj, key, value){
  return Object.assign({}, obj, { [key]: value });
}

function destructivelyUpdateDriverWithKeyAndValue(driver, key, value){
  return Object.assign(driver, { [key]: value });
}

function deleteFromDriverByKey(driver, name){
  const clone = Object.assign({}, driver);
  delete clone[name];
  return clone;
}

function destructivelyDeleteFromDriverByKey(driver, name){
  delete driver[name];
  return driver;
}
