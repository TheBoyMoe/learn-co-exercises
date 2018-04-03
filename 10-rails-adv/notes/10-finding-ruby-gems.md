# How to Find Gems

## Objectives

1. Understand what to look for when choosing a gem.
2. Know where to find popular gems.

## The RubyGems Ecosystem

We've been using gems like crazy at this point, from RSpec for testing to Rails for ... Rails-ing. Many common problems we need to solve have already been solved by someone else and released as a gem, allowing Ruby and Rails developers to reach incredible levels of productivity. This enables us to skip time consuming re-implementation of code common across many projects.

Working in Ruby is a joy and not just because the language itself is developer friendly: Ruby enables people to freely give back to their fellow developers in the form of gems.

## Do I Even Need a Gem?

The wealth of gems available for everyone to use in their projects is one of the things that sets Ruby apart from other languages. A side effect of this is *Gem Madness* - a condition where gem-crazed developers look for a gem to solve every problem without considering if a gem is really needed.

**//Flat-fact:** *Gem Madness* is not currently listed in the DSM-V as an official disorder, but we should all work to raise awareness.

Before we go looking for a gem to solve a problem, we should take a little time to decide if the problem we want to solve is really so big that we need a gem, or if we might be able to figure out (or Google) a way to just write the code ourselves.

## Where To Look

Okay, we know we need a gem, where do we find one?

We can actually look for gems right on our command line. Try this out in your console:

`gem search ^twitter$ -d`

The `gem search` command can take a regular expression and can be very handy if you know the name (or part of the name) of a gem and want to find it quickly.

However, that only searches the name, so if you need to search in a little more open way, the obvious choice is Google. A search of `rails gem problem-description` will probably get you there pretty quickly.

Google, however, isn't great at letting us know if we want the gem it shows us (more on this later), so there are a couple of great resources that provide more context to lists of gems.

[The Ruby Toolbox][ruby_toolbox] is a site that aggregates and categorizes gems, ranking them according to stats like total downloads, releases, and active commits.

The Ruby Toolbox is *comprehensive*, which is a fancy way of saying "it's a lot to go through." Its great if you're looking for something a little more obscure or really want to explore all the options, but sometimes we want a more curated list of which gems are popular in the community.

Enter [Awesome Ruby][awesome_ruby] and [Awesome Rails Gem][awesome_rails], two open-source, community-maintained lists of the most popular gems for Ruby and Rails by category.

**Note:** There are "Awesome" lists for a lot of things, from languages to free programming books and everything in between. Check out the [awesome index][awesome_index].

## Qualities to Look for When Choosing a Gem

Adding a gem to your project means you are taking on a *dependency* on outside code. If that gem has security problems, your project has security problems. If that gem has bugs, your project has bugs. If that gem (or one of the gems it depends on) doesn't keep up with newer versions of Rails, you might be stuck dealing with compatibility problems.

Let's look at some strategies for selecting high quality, reliable, and safe gems for our project.

### How Popular Is It?

This is one time when we want to care about popularity contests. The more popular a gem is, the more likely it is to be maintained, to keep up with security issues, and to be compatible with the latest Rails version.

Beyond that, the more popular a gem is, the more likely you are to be able to find help if you run into problems. Popular gems have a lot of questions and answers on Stack Overflow. People like to blog about popular gems so they can get those sweet, sweet clicks. All that adds up to you feeling confident that you can use that gem.

Some ways to test the popularity are:

1. Look it up on Ruby Toolbox. See how many downloads there are, how recently it's been committed to, and how many versions there are
2. See if it's on the Awesome Ruby or Awesome Rails lists mentioned above
3. Google the gem name and see what's there and, importantly, how recently it was updated. Try things like "gem name tutorials" and "gem name errors"
4. Search Stack Overflow for the gem and read what people say about it
5. Search GitHub for usage of the gem. You'll need to read the gem's documentation or code and pick out a class or method to search for. For example, searching GitHub for `paperclip has_attached_file`, which is a primary method in the [Paperclip][paperclip] gem, yields over 45k results, so it's obviously in wide use

### How Well-Maintained Is It?

We want our gems to be popular, but we also need them to be well-maintained. A well-maintained gem will be far less likely to cause you problems down the road.

Some ways to determine if a gem is well-maintained are:

1. Read the code. Is it put together in the way you'd expect? Can you understand it? Does it follow Ruby idioms and styles?
2. Look for documentation. Is it well-documented? The README, at a bare minimum, should tell you how to get the gem up and running. Even better is a documentation with examples and sample code
3. Look at issues and pull requests. How long do they stay open? How active are the committers in addressing issues and PRs? Are there problems with a specific version that haven't been resolved? **Hint:** This could also be an opportunity to do some open source contributing!
4. Look for tests. Is there a `/test` or `/spec` directory? How many tests are there? Is there a link to a continuous integration build result? Examining the tests is always a great way to learn how the gem works and how well it's put together

## Summary

Gems are great. They're a powerful tool and crucial to your success as a Ruby on Rails developer. But just because there's a gem out there for everything doesn't mean that every gem is the best one to use, so do some due diligence when choosing what to add to your Gemfile.


[ruby_toolbox]: https://www.ruby-toolbox.com/
[awesome_ruby]: https://github.com/markets/awesome-ruby
[awesome_rails]: https://github.com/hothero/awesome-rails-gem
[paperclip]: https://github.com/thoughtbot/paperclip
[awesome_index]: https://github.com/sindresorhus/awesome

