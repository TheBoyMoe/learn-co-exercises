var link = document.getElementById('hide_this') 
link.addEventListener('click', hideWhenClicked)

function hideWhenClicked(event) {
  var elm = event.target
  elm.style.display = 'none'
}
