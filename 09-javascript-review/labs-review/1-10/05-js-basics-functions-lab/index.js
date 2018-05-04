// Code your solution in this file!
const HQ = 42;

function distanceFromHqInBlocks(street){
  // return (street > HQ)? street - HQ : HQ - street;
  return Math.abs(street - HQ);
}

function distanceFromHqInFeet(street){
  return distanceFromHqInBlocks(street) * 264;
}

function distanceTravelledInFeet(start, end){
  // return (end > start)? (end - start) * 264 : (start - end) * 264;
  return Math.abs(end - start) * 264;
}

function calculatesFarePrice(start, destination){
  let distance = distanceTravelledInFeet(start, destination);
  if(distance < 400)  return 0;
  if(distance > 2500) return 'cannot travel that far';

  if(distance > 400 && distance <= 2000){
    return ((distance - 400) * 2)/100;
  } else {
    return 25;
  }

}
