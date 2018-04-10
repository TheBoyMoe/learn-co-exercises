// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('a.load_comments').on('click', function(e){
    e.preventDefault();
    url = e.target.href // or you can use 'this.href'
    $.ajax({
      method: 'GET',
      url: url
    })
    // server response is passed to .done which executes a callback to process the response
    .done(function(response){
      // server responds with the page it would have rendered
      console.log(response)
    })
  })
})
