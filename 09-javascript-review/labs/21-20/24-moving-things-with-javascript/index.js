document.addEventListener("DOMContentLoaded", function(){

  var move = 4
  var dodger = document.getElementById("dodger")
  var gameWindow = document.getElementById('game')
  var dodgerWidth = parseInt(dodger.style.width.replace('px', ''), 10)
  var gameWidth = parseInt(gameWindow.style.width.replace('px', ''), 10)
  var currentLeft = parseInt(dodger.style.left.replace('px', ''), 10)


  function init() {
    dodger.style.backgroundColor = "#cc0000"
    dodger.style.bottom = "50px"
  }

  init()

  // left <- 37, right -> 39
  document.addEventListener('keydown', function (key) {
    if(key.which === 37) {
      moveLeft()
    } else if (key.which === 39) {
      moveRight()
    }
  })


  function moveLeft() {
    // get the current position and move it by 'move' pixel(s)
    if (currentLeft > 0){
      currentLeft -= move
      dodger.style.left = `${currentLeft}px`
    }
  }

  function moveRight() {
    if ((currentLeft + dodgerWidth) < gameWidth){
      currentLeft += move
      dodger.style.left = `${currentLeft}px`
    }
  }

});
