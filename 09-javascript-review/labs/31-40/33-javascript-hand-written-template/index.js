"use strict"

function addComment() {
  // stop the default action of a form to submit form and reload page
  event.preventDefault()
  let bodyText = document.getElementById("commentText").value
  let commenter = document.getElementById("commenterName").value

  let commentBody = createCommentBody(bodyText)
  let commenterLabel = createCommenterLabel(commenter)
  postNewComment(commentBody, commenterLabel)
}

function createCommentBody(comment) {
  let bodyDiv = document.createElement('div')
  let bodyParagraph = document.createElement('p')
  bodyParagraph.textContent = comment
  bodyDiv.appendChild(bodyParagraph)

  return bodyDiv
}

function createCommenterLabel(commenter) {
  let commenterDiv = document.createElement('div')
  let commenterLabel = document.createElement('p')
  commenterLabel.textContent = "posted by: "
  let commenterName = document.createElement('span')
  commenterName.textContent = commenter
  commenterLabel.appendChild(commenterName)
  commenterDiv.appendChild(commenterLabel)

  return commenterDiv
}

function postNewComment(body, commenter) {
  let commentsDiv = document.getElementById('comments')
  let newCommentDiv = document.createElement('div')
  newCommentDiv.appendChild(body)
  newCommentDiv.appendChild(commenter)
  commentsDiv.appendChild(newCommentDiv)
}
