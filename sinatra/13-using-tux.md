## Using Tux

Tux is a ruby gem that can be used to:

* access your database and preform CRUD operations through the CLI.
* make sure your ActiveRecord associations are set up properly.
* loads your app's environment so you can access all routes and views.
* create instances of our models and test methods.

1. To setup Tux simply add the gem to the app's 'Gemfile' and run 'bundle install'.

2. Define any required models, create and run any migrations to create your database tables.

3. From the 'terminal', enter 'tux' to load the 'tux console' where you can use ruby and ActiveRecord methods.

4. Type 'exit' to terminate the session.
