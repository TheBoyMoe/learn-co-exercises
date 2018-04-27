// Code your JavaScript / jQuery solution here

// global variables
var WINING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
];
var turn = 0
var gameId = null;

document.addEventListener("DOMContentLoaded", function(){
  attachListeners();
});


function attachListeners(){
  document.getElementById('save').addEventListener('click', saveGame);
  document.getElementById('previous').addEventListener('click', fetchGames);
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
  document.querySelectorAll('td').forEach((elm)=>{
    array.push(elm.textContent);
  });
  return array;
}

function playerMoves(token) {
  return currentState().reduce((arr, elm, i)=>{
    return (elm === token)? arr.concat(i) : arr;
  }, []);
}

function winningCombination(moves) {
  let i = 0;
  while (i < WINING_COMBINATIONS.length) {
    combination = WINING_COMBINATIONS[i];
    match = combination.every((val)=>{
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
  currentState().forEach((val, i)=>{
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
    saveGame();
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
    if(checkGameOver()) {
      saveGame();
      resetGame();
    }
  }
}

function resetGame(){
  resetBoard();
  turn = 0;
  gameId = null;
}


// AJAX methods /////////////////////////////////////////////////////////

function removeListeners(){
  document.querySelectorAll('td').forEach((elm)=>{
    if(elm.textContent === '') elm.removeEventListener('click', clickHandler);
  });
}

function populateBoard(arr) {
  let squares = document.querySelectorAll('td');
  for (let i = 0; i < 9; i++) {
    squares[i].innerHTML = arr[i];
  }
}

function loadGames(response){
  // populate list and insert in div#games
  let games = document.getElementById('games');
  games.innerHTML = '';
  // let container = document.createElement('ul');
  if(response.data.length > 0){
    response.data.forEach((game)=>{
      let elm = document.createElement('button');
      let content = document.createTextNode(game.id);
      elm.appendChild(content);
      elm.addEventListener('click', fetchGame, false);
      games.append(elm);
    });
  }
}

function loadGame(response){
  // reset state - board, gameId & turn
  setMessage('');
  resetBoard();
  gameId = response.data.id
  let board = response.data.attributes.state;
  populateBoard(board);
  turn = 9 - emptySquares().length;
  if(checkWinner()) removeListeners();
  else if(!checkDraw()) setMessage('Game incomplete!');
}

function loadState(response){
  gameId = response.data.id;
}

function saveGameState(){
  $.post('/games', { state: currentState()}, loadState);
}

function updateGameState(){
  $.ajax({
    type: 'PATCH',
    url: `/games/${gameId}`,
    data: { state: currentState() },
    success: loadState
  });
}

function saveGame(){
  // update the state for a previously saved game
  if(gameId) updateGameState();

  // save game state -> ajax POST => game#create
  else saveGameState();
}

function fetchGames(){
  $.get('/games', loadGames);
}

function fetchGame(event){
  $.get(`/games/${event.target.textContent}`, loadGame);
}

function clearGame(){
  // clear board and start new game
  setMessage('');
  resetGame();
}

