'use strict';

let dodger = document.getElementById('dodger');

dodger.style.backgroundColor = '#FF69B4';
// dodger.style.left = '180px';
// dodger.style.bottom = '20px';


document.addEventListener('keydown', function (evt) {
	if(evt.which === 37){
		moveLeft();
	}
	if(evt.which === 39){
		moveRight();
	}
});


function moveLeft() {
	move(-10);
}

function moveRight() {
	move(10);
}

function move(num){
	let leftNumbers = dodger.style.left.replace('px', '');
	let left = parseInt(leftNumbers, 10);
	if(left > 0)
		dodger.style.left = `${left + num}px`
}
