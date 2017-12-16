Acceptance-Unit Test Cycle
===


Setup your Rails app
----

Once you have the clone of the repo:

1) Change into the project root directory
2) Run `bundle install --without production` to make sure all gems are properly installed.    
3) Run `bundle exec rake db:migrate` and `bundle exec rake db:migrate RAILS_ENV=test` to apply database migrations to both development and test databases.    
4) Run these commands to set up the Cucumber directories (under features/) and RSpec directories (under spec/) if they don't already exist, allowing overwrite of any existing files:

```shell
rails generate cucumber:install capybara
rails generate cucumber_rails_training_wheels:install
rails generate rspec:install
```

5) Create a new file called `rspec.rb` in features/support with the following contents:

```
require 'rspec/core'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
```

This prevents RSpec from issuing DEPRECATION warnings when it encounters deprecated syntax in `features/step_definitions/web_steps`.

6) You can double-check if everything was installed by running the tasks `rspec` and `cucumber`.  

Since presumably you have no features or specs yet, both tasks should execute correctly reporting that there are zero tests to run. Depending on your version of rspec, it may also display a message stating that it was not able to find any _spec.rb files.

Remember to include the line 
`require 'rails_helper'` at the top of your *_spec.rb files.

We want you to report your code coverage as well.

Add `gem 'simplecov', :require => false` to the test group of your gemfile, then run `bundle install --without production`.

Next, add the following code **BEFORE ANYTHING ELSE ON LINE ONE** of spec/rails_helper.rb and features/support/env.rb:

```ruby
require 'simplecov'
SimpleCov.start 'rails'
```

7. Setup Guard to automate your specs

Add the following ruby gem in group :test block

```ruby
    gem 'guard-rspec'
``` 

In the root directory execute

```ruby
    bundle exec guard init rspec
```

to generate the Guardfile. To run guard run

```ruby
    bundle exec guard
```
