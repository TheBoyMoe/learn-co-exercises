// Write your code in this file!
function scuberGreetingForFeet(feet){
  return (feet > 2500)? 'No can do.' : (feet <= 400)? 'This one is on me!' :'I will gladly take your thirty bucks.';
}

function ternaryCheckCity(city){
  return (city === 'NYC')? 'Ok, sounds good.' : 'No go.';
}

function switchOnCharmFromTip(tip){
  switch(tip){
    case 'generous':
      return 'Thank you so much.';
    case 'not as generous':
      return 'Thank you.';
    case 'thanks for everything':
      return 'Bye.';
  }
}
