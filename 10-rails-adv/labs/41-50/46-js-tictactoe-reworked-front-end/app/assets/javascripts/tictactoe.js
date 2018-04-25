// Code your JavaScript / jQuery solution here

// global variables
var WINING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
];
var turn = 0

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
    squares[i].addEventListener('click', clickHandler);
  }
}

function clickHandler(e){
  doTurn(e.target);
}

// returns the appropriate player token, 'X' when 'turn' even, 'O' when odd
function player(){
  return (turn % 2 == 0)? 'X' : 'O';
}

function updateState(elm){
  elm.textContent = player();
  elm.removeEventListener('click', clickHandler);
}

function setMessage(str){
  document.getElementById('message').textContent = str
}

function currentState(){
  let array = [];
  document.querySelectorAll('td').forEach(function(elm){
    array.push(elm.textContent);
  });
  return array;
}

function playerMoves(token) {
  return currentState().reduce(function(arr, elm, i){
    return (elm === token)? arr.concat(i) : arr;
  }, []);
}

function winningCombination(moves) {
  let i = 0;
  while (i < WINING_COMBINATIONS.length) {
    combination = WINING_COMBINATIONS[i];
    match = combination.every(function(val){
      return moves.includes(val)
    })
    if (match) return true;
    i++;
  }
  return false;
}

// return the squares that do not have a token
function emptySquares(){
  let array = [];
  currentState().forEach(function(val, i){
    if(val === '') array.push(i);
  });
  return array;
}

// returns true if the board has a winning combination, returns false otherwise. calls setMessage()
function checkWinner(){
  let xmoves = playerMoves('X');
  let result = winningCombination(xmoves)
  if(result) {
    setMessage('Player X Won!');
  } else {
    let omoves = playerMoves('O');
    result = winningCombination(omoves);
    if(result){
      setMessage('Player O Won!');
    }
  }
  return result;
}

function checkDraw(){
  if(emptySquares().length == 0) {
    setMessage('Tie game.');
    return true;
  }
  return false;
}

function checkGameOver(){
  return (checkWinner() || checkDraw());
}

function doTurn(elm){
  if(elm.textContent === ''){
    updateState(elm);
    turn++;
    if(checkGameOver()) resetGame();
  }
}

function resetGame(){
  resetBoard();
  turn = 0;
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

