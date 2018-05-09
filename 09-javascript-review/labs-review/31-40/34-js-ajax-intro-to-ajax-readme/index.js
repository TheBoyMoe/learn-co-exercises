function getRepositories(){
  const username = 'theboymo';
  const url = `https://api.github.com/users/${username}/repos`;
  const req = new XMLHttpRequest();
  req.addEventListener('load', showRepositories);
  req.open('GET', url);
  req.send();
}

function showRepositories(event, data){
  // 'this' is the 'req' object
  console.log(this.responseText);

  let resultString = '<ul>';
  const repos = JSON.parse(this.responseText);
  for(const repo of repos){
    resultString += `<li><a href="#" data-repo="${ repo['name'] }" onclick="getCommits(this)">${ repo.name }</a></li>`;
  }
  resultString += '</ul>';
  document.getElementById('repositories').innerHTML = resultString;
}

function getCommits(elm){
  const username = 'theboymo';
  const name = elm.dataset.repo;
  const req = new XMLHttpRequest();
  req.addEventListener('load', showCommits);
  req.open('GET', `https://api.github.com/repos/${ username }/${ name }/commits`);
  req.send();
}

function showCommits(){
  console.log(this.responseText);
  const commits = JSON.parse(this.responseText);
  let resultString = '<ul>';
  for(const commit of commits){
    resultString += `<li><strong>${ commit.commit.author.name }</strong> - ${ commit.commit.message }</li>`;
  }
  document.getElementById('commits').innerHTML = resultString;
}
