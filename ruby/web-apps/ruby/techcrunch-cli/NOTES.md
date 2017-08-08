#Common Anti-Patterns in CLI Gem Application
*This video walks through the process of refactoring a CLI Gem fixing common anti-patterns in CLI Gem applications*

## Objectives

1. Define anti-patterns
2. Pinpoint flaws in Gem
3. Zipper Pattern
4. Format user output
5. Decouple scraping functionality
6. Create Instances of our Model/Class

## Resources

1. [Video walkthrough](https://www.youtube.com/embed/cbMa87oWv08)

## Summary

* what do we mean by anti-patterns
* explain our gem functionality
* explain our classes
* find flaws in gem
 * bunch of different arrays of data instead of unified objects
  * explain zipper pattern
  * too many calls to website
  * We never instantiate instances of our class
  * a ton of scraping methods in our story object
  * hard coded maximum number for user input
  * using `each` instead of `collect`
* examine app in pry
* fix formatting for output
* build functionality to scrape individual story  
  * make it work using our zipper pattern
  * fix undefined method error
  * output scraped story
* move scraping logic to a Scraper class
  * change class methods to instance methods
  * define responsibility of Scraper class
  * scrape individul li tags of stories
  * grab individual attributes of that story with css selectors.
  * use those individual story details info to create a new story instance
* add functionalty to Story class to keep track of all its instances
* test scraper functionality
  * last article causes an error
  * use `rescue` to pinpoint source of error
  * create logic to prevent the error stemming from different tags in final article
* implement our new functionality throughout the app
  * use our new logic to obtain and output the storis in cli class
  * add functionality to scrape individual article
* realize how efficiant our app is now that we've utilized Object Orientation
 * a story object now has power and convenenit methods
* commit and examine github diff post refactor

## Code

[Original Code](https://github.com/aviflombaum/techcrunch_cli/tree/pre-refactor)

[Refactored Code](https://github.com/aviflombaum/techcrunch_cli/tree/post-refactor)

[Diff](https://github.com/aviflombaum/techcrunch_cli/compare/pre-refactor...post-refactor?expand=1)
