
// execute the request (fetch the data, without reloading the page)
function getRepositories() {
  const url = "https://api.github.com/users/octocat/repos"
  const req = new XMLHttpRequest()
  req.addEventListener('load', showRepositories)
  req.open('GET', url)
  req.send()
}

function getCommits(link) {
  const name = link.dataset.repo
  const url = `https://api.github.com/repos/octocat/${name}/commits`
  const req = new XMLHttpRequest()
  req.addEventListener('load', showCommits)
  req.open('GET', url)
  req.send()
}

// handle the response (save/display the data) - define na event on the
// request to listen for the load event - tells us when the request is complete
// and executes the callback - in which we handle the data
function showRepositories(e, data) {
  // 'this' is the 'req' object inside our callback
  let repos = JSON.parse(this.responseText)
  console.log(repos)// full body of the response
  let container =   document.getElementById('repositories')

  let repoList = '<ul>'
  for(let i = 0, l = repos.length; i < l; i++){
    repoList += `<li>${repos[i]['name']} - <a href="#" data-repo="${repos[i]['name']}" onclick="getCommits(this)">Get Commits</a></li>`
  }
  repoList += '</ul>'

  container.innerHTML = repoList
}

function showCommits() {
  const commits = JSON.parse(this.responseText)
  const container = document.getElementById("commits")
  container.innerHTML = `<ul>${commits.map(commit => '<li><strong>' + commit.commit.author.name + '</strong> - ' + commit.commit.message + '</li>').join('')}</ul>`
}
