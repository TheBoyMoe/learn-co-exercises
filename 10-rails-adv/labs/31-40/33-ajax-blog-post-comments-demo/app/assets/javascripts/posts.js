// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// 1. use ajax to submit form data
// $(function(){ // equivalent to document ready
//   $("#new_comment").on('submit', function(e){
//     comments_url = e.target.action // or this.action
// 
//     data = {
//       'authenticity_token' : $("input[name='authenticity_token']").val(),
//       'comment': {
//         'content': $("#comment_content").val()
//       }
//     }
//     
//     $.ajax({
//       type: 'POST',
//       url: comments_url,
//       data: data,
//       success: function(response){
//         $("#comment_content").val("") // clear textarea
//         $("div.comments ul").append(response)
//         $("input[type='submit']").removeAttr('disabled')
//       }
//     })
// 
//     e.preventDefault();
//   });
// })

//  2. make the ajax call more generic
// $(function(){ // equivalent to document ready
//   $("#new_comment").on('submit', function(e){
// 
//    $.ajax({
//       type: ($("input[name='_method']").val() || this.method), // capture patch/put/delete or post
//       url: this.action,
//       data: $(this).serialize(), // serialize the form data
//       // the callback is the only part that is unique - this can be programmed on the server side too - use remote: true
//       success: function(response){
//         $("#comment_content").val("") // clear textarea
//         $("div.comments ul").append(response)
//         $("input[type='submit']").removeAttr('disabled')
//       }
//     })
// 
//     e.preventDefault();
//   });
// })
