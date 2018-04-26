// Code your JavaScript / jQuery solution here

// global variables
var WINING_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
];
var turn = 0
var gameId = null;
// var squares = document.querySelectorAll('td');

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
  let container = document.createElement('ul');
  if(response.data.length > 0){
    response.data.forEach((game)=>{
      let elm = document.createElement('li');
      let content = document.createTextNode(game.id);
      elm.appendChild(content);
      elm.addEventListener('click', fetchGame, false);
      container.appendChild(elm);
    });
    games.append(container);
  } else {
    games.innerHTML = "<p>No games have been saved</p>";
  }
}

function loadGame(response){
  // reset state - board, gameId & turn
  gameId = response.data.id
  setMessage('');
  let board = response.data.attributes.state
  turn = board.length - emptySquares().length;
  resetBoard();
  populateBoard(board);
  if(checkWinner()) removeListeners();
  else if(!checkDraw()) setMessage('Game incomplete!');
}

function loadState(response){
  if(turn > 0) gameId = response.data.id;
}

function saveGameState(){
  $.ajax({
    type: 'POST',
    url: '/games',
    data: { state: currentState() },
    success: loadState,
    error: function(){alert('Error saving game.')}
  });
}

function updateGameState(){
  $.ajax({
    type: 'PATCH',
    url: `/games/${gameId}`,
    data: { state: currentState() },
    success: loadState,
    error: function(){ alert('Error updating game.')}
  });
}

function saveGame(){
  // update the state for a previously saved game
  if(gameId) updateGameState();

  // save game state -> ajax POST => game#create
  else saveGameState();
}

function previousGame(){
  // fetch games -> ajax GET => game#index
  $.get({
    url: '/games',
    dataType: 'json',
    // callback -> display game list
    success: loadGames,
    error: function(){ alert('Error retrieving games from server.'); }
  });
}

function fetchGame(event){
  // fetch game upon item click -> ajax GET => game#show
  $.get({
    url: `/games/${event.target.textContent}`,
    dataType: 'json',
    // callback -> populate board & set turn value
    success: loadGame,
    error: function(){ alert('Error retrieving game from server.') }
  });
}

function clearGame(){
  // clear board and start new game
  setMessage('');
  resetGame();
}

