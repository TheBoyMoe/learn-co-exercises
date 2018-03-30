
const details = document.getElementById('details')
const errors = document.getElementById('errors')
const results = document.getElementById('results')
const search = document.getElementById('searchTerms')

function executeSearch(url) {
  $.get(url)
    .done((data)=>{
     showRepositories(data)
    })
    .fail((error)=>{
      displayError(error)
    })
}

function displayError(error) {
  errors.innerHTML = `I'm sorry, there's been an error. Please try again.\n ${error}`
}

function searchRepositories() {
  const searchTerms = search.value
  const url = `https://api.github.com/search/repositories?q=${searchTerms}`
  executeSearch(url)
}

function showRepositories(data) {
  console.log(data.items)
  results.innerHTML = `<ul>${data.items.map((repo)=>{
    return '<li>' +
        '<h2>'+ repo["full_name"] + '&nbsp;(' + repo.owner.login +')</h2>' +
        '<img src="'+ repo.owner["avatar_url"] +'" alt="owner avatar" width="60" height="60"><br>' +
        '<a href="'+ repo.owner["html_url"] +'" target="_blank">View profile</a>' +
        '<h3>Repository</h3>' +
        '<p>'+ repo.description +'</p>' +
        '<a href="'+ repo["html_url"] +'" target="_blank" >View Repository</a>&nbsp;' +
        '<a href="#" data-owner="'+ repo.owner.login +'" data-repository="'+ repo.name +'" onclick="showCommits(this)">View Commits</a>' +
      '</li>'
  }).join('')}</ul>`
}


function showCommits(link) {
  const owner = link.dataset.owner
  const reponame = link.dataset.repository
  const url = `https://api.github.com/repos/${owner}/${reponame}/commits`
  $.get(url)
    .done((data)=>{
      displayCommits(data)
    })
    .fail((error)=>{
      displayError(error)
    })
}

function displayCommits(commits) {
  details.innerHTML = `<ul>${commits.map((obj)=>{
    return '<li>' +
      '<h3>'+ obj.commit.author.name +'&nbsp;('+ obj.author.login +')</h3>' +
      '<img src="'+ obj.author["avatar_url"] +'" alt="owner avatar" width="60" height="60"><br>' +
      '<p>'+ obj.commit.message +'</p>' +
      '<p>'+ obj.sha +'</p>' +
      '</li>'
  }).join('')}</ul>`
}