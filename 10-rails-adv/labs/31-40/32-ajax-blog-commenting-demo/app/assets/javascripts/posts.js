// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){ // equivalent to document ready
  $("a.load_comments").on('click', function(e){

    comments_url = e.target.href // or you can use 'this.href'
   
    // SERVER RESPONDING WITH HTML
    // $.ajax({
    //   method: 'GET',
    //   url: comments_url,
    //   success: function(response){
    //     $("div.comments").html(response);
    //   },
    //   error: function(error){
    //     $("div.comments").html("<p>Error retrieving data from server!</p>");
    //   }
    // });

    // .done(function(response){
    //   // server responds with the page it would have rendered
    //   console.log(response)
    //   $("div.comments").html(response)
    // })
    // .error(function(error){
    //   $("div.comments").html(<p>Error retrieving data from server!</p>)
    // });
    
    // simpler tech using .get()
    // $.get(comments_url)
    //   .success(function(response){
    //     $("div.comments").html(response)
    // })
    //   .error(function(error){
    //     $("div.comments").html("<p>Error retrieving data from server!</p>")
    // });

    // SERVER RESPONDS WITH JSON, jquery automatically parses json
    $.get(comments_url).success(function(json){
      var $list = $("div.comments ul")
      $list.html("") // clear contents
      json.forEach(function(comment){
        $list.append(`<li>${comment.content}</li>`);
      });
    })

    e.preventDefault();
  });
})

