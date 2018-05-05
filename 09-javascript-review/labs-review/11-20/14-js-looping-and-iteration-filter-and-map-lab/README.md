# Filter and Map Lab

## Overview
In this lab, we'll use our `filter` and `map` functions to write functions that properly query our data and return new arrays.

## Instructions
Be sure to run the tests to get a feel for the types of problems this lab is asking you to solve.

You'll be writing four functions:
* `driversWithRevenueOver`- This function takes an array of `driver` JavaScript objects as the first argument and a string called `revenue` as the second argument. It returns an array of `driver` objects that have a `revenue` attribute that's greater than the passed-in `revenue` argument.
* `driverNamesWithRevenueOver()` - This function works the same way as `driversWithRevenueOver()`. The difference is that it returns an array of strings representing the name of each driver who has a revenue greater than the specified amount. For example, `driverNamesWithRevenueOver(drivers, 2000)` will return `['Sammy']`, as `Sammy` is the name of the matching `driver` object with a revenue greater than `2000`.
* `exactMatch()` - This function takes an array of `driver` objects as the first argument and a JavaScript object that specifies an attribute and corresponding value. For example, `exactMatch(drivers, { revenue: 3000 })` will return all drivers whose `revenue` attribute equals `3000`, and `exactMatch(drivers, { name: 'Bob' })` will return all drivers whose `name` attribute equals `Bob`.
* `exactMatchToList()` - This function works the same way as the `exactMatch()` function, except that instead of returning an array of `driver` objects, it returns an array of strings with each element in the array corresponding to the matching driver's name. For example, `exactMatchToList(drivers, { revenue: 2000 })` will return `['Sammy']`, as `Sammy` is the name of the matching `driver` object.

## Resources
- [MDN: Filter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
- [MDN: Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)

<p class='util--hide'>View <a href='https://learn.co/lessons/js-looping-and-iteration-filter-and-map-lab'>Filter and Map Lab</a> on Learn.co and start learning to code for free.</p>
