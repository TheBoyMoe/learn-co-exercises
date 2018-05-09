const app = "I don't do much.";

// generic api request using fetch
function getCommitsUsingFetch(){
  const url = '';
  fetch(url)
    .then(response => response.json())   // parse the response
    .then(json => displayCommits())      // display json data
    .catch(error => console.log(error)); // catch any thrown errors
}

// implement fetch with authentication
function getAuthenticatedData(){
  const url = '';
  const token = '';
  fetch(url, {
    headers: { Authorization: `token ${ token }` }
  })
    .then(response => response.json())
    .then(json => showRepositories())
    .catch(error => console.log(error));
}

