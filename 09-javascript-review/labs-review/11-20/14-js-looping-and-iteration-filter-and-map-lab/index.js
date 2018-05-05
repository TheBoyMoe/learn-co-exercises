// Code your solution here:

function driversWithRevenueOver(array, value){
  return array.filter(obj => obj.revenue > value);
}

function driverNamesWithRevenueOver(array, value){
  return driversWithRevenueOver(array, value).map(obj => obj.name);
}

function exactMatch(array, obj){
  return array.filter((elm)=>{
    return elm.name === obj.name || elm.revenue === obj.revenue;
  });
}

function exactMatchToList(array, obj){
  return exactMatch(array, obj).map(elm => elm.name);
}
