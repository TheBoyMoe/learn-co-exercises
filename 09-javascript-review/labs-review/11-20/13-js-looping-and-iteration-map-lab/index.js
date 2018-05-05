// Code your solution in this file.

function lowerCaseDrivers(array){
  return array.map(elm => elm.toLowerCase());
}

function nameToAttributes(array){
  return array.map((name)=>{
    let names = name.split(' ');
    return Object.assign({}, { firstName: names[0], lastName: names[1] });
  });
}

function attributesToPhrase(array){
  return array.map((obj)=>{
    return `${obj.name} is from ${obj.hometown}`;
  });
}
