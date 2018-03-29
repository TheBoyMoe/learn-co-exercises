document.addEventListener("DOMContentLoaded", function (event) {
  // register handlebars templates when page loads
  let partial = document.getElementById('author-partial-template').innerHTML
  Handlebars.registerPartial('authorPartial', partial)
})


function getRepositories() {
  const url = 'https://api.github.com/users/octocat/repos'
  const req = new XMLHttpRequest()
  // req.addEventListener('load', displayRepositories)
  req.addEventListener('load', showRepositories)
  req.open('GET', url)
  req.send()
}

function displayRepositories(event, data) {
  const repos = JSON.parse(this.responseText)
  const container = document.getElementById('repositories')
  container.innerHTML = `<ul>${repos.map((repo)=>{
    return '<li>' +
              '<h2><a href="'+ repo.html_url +'" target="_blank">'+ repo.name +'</a></h2>' +
              '<p>Watchers: '+ repo.watchers_count +'</p>' +
              '<p>Forks: '+ repo.forks_count +'</p>' +
              '<p>Issues: '+ repo.open_issues_count +'</p>' +
            '</li>'    
  }).join('')}</ul>`
}

// display git repositories using a handlebars template
function showRepositories(event, data) {
  const repos = JSON.parse(this.responseText)
  const container = document.getElementById('repositories')
  const src = document.getElementById('repository-template').innerHTML
  const template = Handlebars.compile(src)
  container.innerHTML = template(repos)
}
