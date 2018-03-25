/*
 * insert comment into "#comments" in format
 * <div class="comment">
 *   <p>comment</p>
 *   <p>Posted By: <span class="commenter">commenter</span></p>
 * </div>
 */

"use strict;"

function postComment() {
  event.preventDefault()
  let commentsDiv = document.getElementById("comments")
  let commenter = document.getElementById("commenterName").value
  let comment = document.getElementById("commentText").value

  // template string using interpolation with lodash - replaced by #comment-template script
  // let commentTemplate = '<div class="comment"><p><%= comment %></p><p>Posted by: <span class="commenter"><%= commenter %></span></p></div>'

  // we can query the script tag like any html tag, read its contents, and use that as our template string.
  let commentTemplate = document.getElementById('comment-template').innerHTML


  // create template function
  let templateFn = _.template(commentTemplate)
  // execute our function, passing in a JSON object with our values
  let templateHTML = templateFn({'comment': comment, 'commenter': commenter})
  // append the result to our comments div
  commentsDiv.innerHTML += templateHTML
}
