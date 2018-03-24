# JavaScript Map-Reduce Lab


## Overview

In this lab, you'll practice using `reduce()` and `map()` both separately and together on real data. 


## Introduction

This is it, the final challenge! Now that we're confident in our ability to use `.map()` and `.reduce()`, these challenges should prove sufficiently easy!

In this lab, we're going to work with GitHub API data — more specifically, issues related to courses on Learn.co. We'll analyze this data using `.map()` and `.reduce()`, providing us with (some not so) valuable insights!

## Updating the API
Let's say GitHub has updated their API URL. That means we're using old data! Let's bring our data up-to-date.

* Create a variable called `issuesWithUpdatedApiUrl`
* The value of this variable is the mapped `issues` array, replacing any mention of `'api.github.com'` (in `issue.url`)
with `'api-v2.github.com'`
* Make sure you don't modify the _original_ objects in the `issues` array

## Counting the comments
To get a quick overview of our community's activity, let's sum up all comments of every issue.

* The result should be in a variable called `commentCountAcrossIssues`
* First, map the `issues` array and pull out the `comments_count`, to make things easier
* Next, reduce the array of comment counts and add them all together
* Feel free to chain these operations on the `issues` array for brevity — no need for a temporary variable!

## Filtering for open issues
Looking at the data, it seems like some issues are closed already. Those aren't really relevant, so let's create a new array that only has _open_ issues.

* The result should be in a variable called `openIssues`
* This new array should only contain issues where `issue.state` is set to `'open'`

## I'm not a robot
Some issues have been automatically created by the Learn.co bot. Let's filter these out, so we only see issues created by actual humans.

* The result should be in a variable called `nonAutomaticIssues`
* This new array should only contain issues that are not automatically created
* Hint: check the `issue.body` for a clue

## Showing off
Now that we have our `nonAutomaticIssues`, let's print these out in a table in our HTML page. The base markup has been provided for you in `index.html` — all we need to do is add rows to the table body.

* Use the DOM API to set the HTML of the table body to a list of table rows that have three columns: the issue body, the date and the state of the issue (open or closed)
* To easily create your HTML markup for all the rows, use `.map()`
* Hint: the `innerHTML` property expects a string, so don't forget to turn your array into one big string by using [`.join()`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/join)

## Resources

- [MDN: Array.prototype.map()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)
- [MDN: Array.prototype.reduce()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)
