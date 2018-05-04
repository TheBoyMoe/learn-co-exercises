// Code your solution in this file

function findMatching(array, name){
  return array.filter(elm => elm.toLowerCase() === name.toLowerCase());
}

function fuzzyMatch(array, characters){
  return array.filter((elm)=>{
    return elm.slice(0, characters.length) === characters;
  });
}

function matchName(array, name){
  return array.filter((obj)=>{
    return obj.name === name;
  });
}

