# Basic APIs Lab

## Objectives

  1. Set up a Github API app.
  2. Read API documentation and figure out API calls.
  3. Use Faraday to make GET requests from the Github API.
  4. Read the response and display certain elements on a page.

## Instructions

We're going to create a Rails application that will allow the user to
search for Github repositories via the [Github API](https://developer.github.com/v3/).

The basic Rails app has been provided. You'll need to implement the API
parts and make the tests pass. This lab will test your documentation
reading skills as well as your coding skills!

1. Set up a [Github app](https://github.com/settings/developers) and get a Client ID and Secret for use with
   this lab.
2. Update the `RepositoriesController` and use Faraday to query the Github
   [repository search](https://developer.github.com/v3/search/#search-repositories). Use your [client ID and secret](https://developer.github.com/v3/#increasing-the-unauthenticated-rate-limit-for-oauth-applications) for the request.
3. Display the search results on the page. Include the name, a link to
   the repository, and the description.
4. Try it out, and make sure all tests pass!
