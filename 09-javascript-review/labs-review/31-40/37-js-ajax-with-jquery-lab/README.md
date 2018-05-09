# AJAX and Callbacks Lab

## Objectives

+ Use Ajax's `get` method
+ Use the `success` callback
+ Use the `error` callback
+ Read the API documentation

## Introduction

Let's put our new Ajax skills to work by making a GitHub repository search client. This lab will test your ability to use jQuery's `$.get` function with callbacks and give you some more practice reading API documentation.

All of the HTML and JavaScript files have been provided. The file `index.html` has a basic two-column structure, and you'll add your JavaScript code to `index.js`. Don't forget to run the tests, and be sure to load your page up in the browser to make sure everything's working!

## Instructions

We're making a GitHub repository search client. It should take a user's search terms, query the GitHub search API for repositories, and display the results in the left-hand column. The user can then click various links in each repository to get more detailed information in the right-hand column.

1. Create a "Search Repositories" link that calls a `searchRepositories` function on click, takes the value of a `searchTerms` text input, and queries the GitHub repository search API.
2. Display the collection of repositories inside the `results` div. Include repository name, description, and a link to the HTML URL. Also include repository owner login, repository owner avatar as an image, and a link to the owner's profile page. **Hint:** Pay close attention to the structure of the search results!
3. Add a "Show Commits" link to each repository result that will call a `showCommits` function that gets the repository's commits from the GitHub API and display them in the `details` div. For each commit, list the SHA, the author, the author's login, and the author's avatar as an image.
4. Handle errors on each API call. If `$.get` fails, call a function `displayError` and display "I'm sorry, there's been an error. Please try again." in the `errors` div. **Hint:** You can test your error callbacks by turning off Wi-Fi or temporarily changing the URL you use in the `$.get` request.

## Resources

- [jQuery.get](http://api.jquery.com/jquery.get/)
- [GitHub API](https://developer.github.com/v3/)

<p class='util--hide'>View <a href='https://learn.co/lessons/js-ajax-callbacks-lab' title='AJAX and Callbacks Lab'>AJAX and Callbacks Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/js-ajax-callbacks-lab'>AJAX and Callbacks Lab</a> on Learn.co and start learning to code for free.</p>
