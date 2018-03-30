// classical way of getting data from a api using vanilla javascript
"use strict";
const container = document.getElementById('results')

function getCommits() {
  const url = "https://api.github.com/repos/jquery/jquery/commits"
  const xhr = new XMLHttpRequest()
  xhr.open('GET', url)
  xhr.responseType = 'json'
  xhr.onload = ()=>{
    console.log(xhr.response)
    displayCommits(xhr.response)
  }
  xhr.error = ()=>{
    console.log("Error")
    container.innerHTML = "You fucked up Joe!"
  }
  xhr.send()
}


// Getting data using the Fetch API
function getCommitsUsingFetch() {
  const url = "https://api.github.com/repos/jquery/jquery/commits"
  fetch(url)
    .then((response)=>{
      return response.json()
    })
    .then((json)=>{
      console.log(json)
      displayCommits(json)
    })
    .catch((error)=>{
      console.log(error)
    })
}


// Implementing Fetch API with Authentication
// Github Personal token: xxxxxxxxxxxxxx
function getAuthenticatedData() {
  const url = 'https://api.github.com/user/repos'
  const token = 'xxxxxx-xxxxxxx-xxxxxxx-xxxxxx'
  fetch(url, {
    headers: { Authorization: `token ${token}`}
  })
    .then(response => response.json())
    .then((json) => {
      console.log(json)
      showRepositories(json)
    })
    .catch(error => console.log(error))
}


function displayCommits(commits) {
  container.innerHTML = `<ul>${commits.map((obj)=>{
    return '<li>' +
      '<h3>'+ obj.commit.author.name +'&nbsp;('+ obj.author.login +')</h3>' +
      '<img src="'+ obj.author["avatar_url"] +'" alt="owner avatar" width="60" height="60"><br>' +
      '<p>'+ obj.commit.message +'</p>' +
      '<p>'+ obj.sha +'</p>' +
      '</li>'
  }).join('')}</ul>`
}


function showRepositories(data) {
  container.innerHTML = `<ul>${data.map((repo)=>{
    return '<li>' +
        '<h2>'+ repo["full_name"] + '&nbsp;(' + repo.owner.login +')</h2>' +
        '<img src="'+ repo.owner["avatar_url"] +'" alt="owner avatar" width="60" height="60"><br>' +
        '<a href="'+ repo.owner["html_url"] +'" target="_blank">View profile</a>' +
        '<h3>Repository</h3>' +
        '<p>'+ repo.description +'</p>' +
        '<a href="'+ repo["html_url"] +'" target="_blank" >View Repository</a>&nbsp;' +
      '</li>'
  }).join('')}</ul>`
}

