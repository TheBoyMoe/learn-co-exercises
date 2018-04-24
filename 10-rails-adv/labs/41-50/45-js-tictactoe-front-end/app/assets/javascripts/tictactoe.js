// Code your JavaScript / jQuery solution here

const WINING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
];

// global variables
var turn = 0
var state = Array.from(Array(9).keys());

document.addEventListener("DOMContentLoaded", function(){
  attachListeners();
});


function attachListeners(){
  document.getElementById('save').addEventListener('click', saveGame);
  document.getElementById('previous').addEventListener('click', previousGame);
  document.getElementById('clear').addEventListener('click', clearGame);
  resetBoard();
}

function resetBoard(){
  let squares = document.querySelectorAll('td');
  for(let i = 0; i < squares.length; i++){
    squares[i].textContent = '';
    squares[i].addEventListener('click', doTurn);
  }
}

function resetState(){
  state = Array.from(Array(9).keys());
  turn = 0;
}

function mapXYToIndex(x,y){
  let index;
  // return index
  if(x == 0){
    if(y == 0){
      index = 0;
    } else if(y == 1){
      index = 3;
    } else if(y == 2){
      index = 6;
    }
  } else if(x == 1) {
    if(y == 0){
      index = 1;
    } else if(y == 1){
      index = 4;
    } else if(y == 2){
      index = 7;
    }
  } else if(x == 2){
    if(y == 0){
      index = 2;
    } else if(y == 1){
      index = 5;
    } else if(y == 2){
      index = 8;
    }
  }
  return index;
}

// returns the appropriate player token, 'X' when 'turn' even, 'O' when odd
function player(){
  return (turn % 2 == 0)? 'X' : 'O';
}

// takes elm that was clicked, calls player(), adds 'X'/'O' to approriate square
function updateState(elm){
  let x = elm.dataset.x;
  let y = elm.dataset.y;
  let token = player();
  let index = mapXYToIndex(x,y);

  // update board
  let square = document.querySelector('td[data-x="' + x + '"][data-y="' + y + '"]');
  square.textContent = token
  square.removeEventListener('click', doTurn);

  // update state array
  state[index] = token;
}


// accepts str, adds to 'div#message' elm
function setMessage(str){
  document.getElementById('message').textContent = str
}

function playerMoves() {
  let token = player();
  return state.reduce(function(arr, elm, i){
    return (elm === token)? arr.concat(i) : arr;
  }, []);
}

function winningCombination(playerMoves) {
  let i = 0;
  while (i < WINING_COMBINATIONS.length) {
    combination = WINING_COMBINATIONS[i];
    match = combination.every(function(val){
      return playerMoves.includes(val)
    })
    if (match) return true;
    i++;
  }
  return false;
}

// return the squares that do not have a token
function emptySquares(){
  return state.filter(function(square){
    return typeof square === 'number';
  })
}

function removeListeners(){
  let empties = emptySquares();
  let squares = document.querySelectorAll('td');
  empties.forEach(function(val){
    squares[val].removeEventListener('click', doTurn);
  })
}

// returns true if the board has a winning combination, returns false otherwise. calls setMessage()
function checkWinner(){
  let moves = playerMoves();
  let result = winningCombination(moves)
  if(result) {
    setMessage(`Player ${player()} Won!`);
    removeListeners();
  }
  return result;
}

function checkDraw(){
  if(emptySquares().length == 0) {
    setMessage('Game a Draw!');
    return true;
  }
  return false;
}

function doTurn(e){
  turn++;
  // updateState, passing elm that was clicked
  updateState(e.target);
  if(!checkWinner() && !checkDraw()) computerTurn();
}

function computerTurn(){
  turn++;
  let squares = document.querySelectorAll('td');
  let squareIndex = emptySquares()[0]; //retrieve the first empty square
  updateState(squares[squareIndex]);
  if(!checkWinner()) checkDraw();
}

function populateBoard(array){
  state = array;
}

function resetGame(){
  resetBoard();
  resetState();
}

function saveGame(){
  setMessage('save game');
}

function previousGame(){
  setMessage('previous game');
}

function clearGame(){
  setMessage('');
  resetGame();
}

