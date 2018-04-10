// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('a.load_comments').on('click', function(e){
    e.preventDefault();
    alert('you clicked the link')
  })
})
