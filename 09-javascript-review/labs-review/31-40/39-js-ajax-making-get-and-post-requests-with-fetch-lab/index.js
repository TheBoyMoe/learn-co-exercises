"use strict";
const username = 'theBoyMo'
const base_url = 'https://api.github.com/repos'

function getIssues() {
  const url = `${base_url}/${username}/javascript-fetch-lab/issues`
  fetch(url, {
      method: 'get',
      headers: {Authorization: `token ${getToken()}`}
    })
    .then(response => response.json())
    .then(json => showIssues(json))
    .catch(error => console.log(error))
}

function showIssues(json) {
  const container = document.getElementById('issues')
  container.innerHTML = `<ul>${ json.map((obj)=>{
    return `<li><h3>${ obj.user.login }</h3>
      <img src="${ obj.user['avatar_url'] }" alt="owner avatar" width="60" height="60"><br>
      <p>${ obj.body }</p></li>`;
  }).join('')}</ul>`
}

function createIssue() {
	const title = document.getElementById('title').value
  const body = document.getElementById('body').value
  const postData = {title: title, body: body}
  const url = `${base_url}/${username}/javascript-fetch-lab/issues`

  fetch(url, {
      method: 'post',
      body: JSON.stringify(postData),
      headers: {Authorization: `token ${getToken()}`}
    })
    .then(response => getIssues()) // fetch and display all issues
    .catch(error => console.log(error))
}

function showResults(json) {
	const container = document.getElementById('results');
  container.innerHTML = `<p><a href="${ json['html_url'] }" target="_blank">${ json.name }</a></p>`;
}

function forkRepo() {
	// GET /repos/:owner/:repo/forks
  const repo = 'learn-co-curriculum/javascript-fetch-lab'
  const url = `${base_url}/${repo}/forks`
  fetch(url, {
      method: 'post',
      headers: {Authorization: `token ${getToken()}`}
    })
    .then(response => response.json())
    .then(json => showResults(json))
    .catch(error => console.log(error))
}

function getToken() {
  //change to your token to run in browser, but set
  //back to '' before committing so all tests pass
  return '';
}
