## Active Record Setup in Sinatra

ActiveRecord support needs to be added, requiring a number of steps

1. Add the following gems to your `gem` file and run `bundle install`.

  **activerecord**            provides database mapping(orm) and association features
  **rake**                    lets us automate database tasks such as creating and running migrations
  **sinatra-activerecord**    provides some built in rake tasks

  **sqlite3**                 our database adapter, enables the app to communicate with the database using ruby
  **tux**                     provides an interactive console that pre-loads the database and ActiveRecord relationships


Our gem file:

```ruby
  gem 'sinatra'
  gem 'activerecord', '4.2.5'
  gem 'sinatra-activerecord'
  gem 'rake'
  gem 'thin'
  gem 'require_all'

  group :development do
      gem 'shotgun'
      gem 'pry'
      gem 'tux'
      gem 'sqlite3'
  end

  group :test do
    gem 'rspec'
    gem 'capybara'
    gem 'rack-test'
  end
```

The `tux` and `sqlite3` gems are not used in production, so are placed in the `:development` group.  

2. Setup the database connection

Add the following code block to your `environment.rb` file

```ruby
  configure :development do
    set :database, 'sqlite3:db/development.sqlite'
  end
```

Example `environment.rb` file(updated):

```ruby
  ENV['SINATRA_ENV'] ||= "development"

  require 'bundler/setup'
  Bundler.require(:default, ENV['SINATRA_ENV'])

  # database adapter - replaces the block above
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )

require_all 'app'
```

3. Run your rake tasks

Add a `Rakefile` to the root of the project and add the following lines:

```ruby
  # load our environment
  require './config/environment'
  # make the rake tasks in the sinatra-activerecord gem available
  require 'sinatra/activerecord/rake'
```

View available rake tasks with the `rake -T` command.
