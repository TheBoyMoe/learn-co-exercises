# Working with APIs

## Instructions

1. This lab begins where the [Rails Github API](https://github.com/learn-co-curriculum/rails-github-api/) lab leaves off. You're provided with a solution to that lab.

2. Create a new model `GithubRepo` in `app/models/github_repo.rb`. Since you're not storing `GithubRepo` in a database, this class does _not_ need to inherit from Active Record. Create the file manually – using `rails g model` will automatically inherit from Active Record and create a migration. Build out the `GithubRepo` class to pass the model tests.

3. Move authentication from your controller to your service objects.

4. Implement the `#initialize` method for your `GithubService` objects.

5. Move the rest of your API calls into the `GithubService` object. Follow the path laid out in the tests, and get the application refactored and working. You will have to change the ERB file as well as your `#logged_in?` method.
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-refactoring-apis' title='Working with APIs'>Working with APIs</a> on Learn.co and start learning to code for free.</p>
