// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){ // equivalent to document ready
  $("#new_comment").on('submit', function(e){
    comments_url = e.target.action // or this.action

    data = {
      'authenticity_token' : $("input[name='authenticity_token']").val(),
      'comment': {
        'content': $("#comment_content").val()
      }
    }
    
    $.ajax({
      type: 'POST',
      url: comments_url,
      data: data,
      success: function(response){
        $("#comment_content").val("") // clear textarea
        $("div.comments ul").append(response)
        $("input[type='submit']").removeAttr('disabled')
      }
    })

    e.preventDefault();
  });
})

