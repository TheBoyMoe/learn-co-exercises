
function createPost() {
  event.preventDefault()
  var pageTemplateFn = _.template(document.getElementById('page-template').innerHTML)
  var postTemplateFn = _.template(document.getElementById('post-template').innerHTML)
  var commentsTemplateFn = _.template(document.getElementById("comments-template").innerHTML);

  var postElement = document.getElementById('post')
  var mainContent = document.getElementsByTagName('main')[0]

  var postTitle = document.getElementById('postTitle').value
  var postContent = document.getElementById('postContent').value
  var postAuthor = document.getElementById('postAuthor').value

  // insert the pageTemplate
  mainContent.innerHTML += pageTemplateFn()

  // create the post
  postElement.innerHTML = postTemplateFn({'title': postTitle, 'content': postContent, 'author': postAuthor})

  postElement.getElementsByTagName("footer")[0].innerHTML = commentsTemplateFn()
}


function postComment() {
  var commentTemplate = _.template(document.getElementById('comment-template'))
  var commentText = document.getElementById("commentText").value;
  var commenterName = document.getElementById("commenterName").value;

  var commentsSection = document.getElementById("comments");
  commentsSection.innerHTML += commentTemplate({ 'commenter': commenterName, 'comment': commentText });
}
