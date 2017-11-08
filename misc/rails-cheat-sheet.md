## Cheatsheet

### Rails

*rails console*

loads full rails environment and development database - changes to the database are saved
$ rails c

loads the rails environment giving access to the test database - changes to the database are saved
$ rails c test

loads the rails environment and the development database - changes to the database are rolled back on exit
$ rails c --sandbox


*rails generator*

General syntax for the rails generator command. '--no-test-framework' flag tells the generator not to create any tests

```bash
  $ rails generate [name of generator] [options] --no-test-framework
```

*generate a migration*

Example of adding, removing & changing a column

```bash
  rails g migration add_published_status_to_posts published_status:string --no-test-framework
  # remove the same column
  rails g migration remove_published_status_from_posts published_status:string --no-test-framework

  rails g migration add_post_status_to_posts post_status:boolean --no-test-framework
  # change the columns data_type
  rails g migration change_post_status_data_type_to_posts post_status:string --no-test-framework

  # creates the change migration, but you need to fill it in, e.g, add
  change_column :posts, :post_status, :string
```


*generate a controller*

Use them when creating static views or non-CRUD features(creates unnecessary views and the wrong routes for a CRUD feature)

```bash
  # creates the controller and updates the routes table, creates a view template for each action, helper file and a series of assets
  $ rails g controller [controller_name] [action_name] ... --no-test-framework

  $ rails g controller admin dashboard stats financials settings --no-test-framework
```

*undo/delete a controller*

```bash
  $ rails destroy controller [controller_name]
```

*generate a model*

```bash
  # create the migration and model in one go
  $ rails g model [model - singular] [attribute:data_type] [attribute:data_type] ... --no-test-framework

  $ rails g model Author name:string genre:string bio:text --no-test-framework
```

*undo/delete model*

```bash
  $ rails destroy model [model]
```

*generate a resource*

If your building an api, or want to manually create your views - use a resource generator.

```bash
  # creates the controller, folder for the views, model (account), migration, and updated routes.rb with a full resources call(creates routes for all CRUD operations)
  rails g resource Account name:string payment_status:string --no-test-framework
```



*updating model objects/instances*

$ user.update_attributes(name: 'tom', email: 'tom@example.com')

accepts a hash of attributes
updates the database record
if the model uses validations, if any fail, the update will fail

$ user.update_attribute(:name, 'tom jones')

update a single attribute
updates the database record
skips any validations


*reload the model instance from the database*

$ user.reload
$ user.reload.name

ensures the instance in memory reflects the record in the database

*delete a database record*

$ user.destroy

*error creating a user - in console*

$ user.errors
$ user.errors.full_messages

*display user attributes - in console*

puts user.attributes.to_yaml

*display routing table*

rails routes

*setting up a new Rails project with Rspec*

Create the rails app with the `new` keyword, adding the `-T` option to tell the generator not to include the default test framework `TestUnit`, add `--without production` to stop the installation of production gems,

$ rails new [app_name] -T

in the gem file add:
gem 'rspec-rails'

after running `bundle install`, create the initial RSpec config:
$ rails g rspec:install

*generate migration in rails*

$ rails generate migration [file_name]

*run the migration*

$ rails db:migrate

*undo migration*

$ rails db:rollback

to go back to the beginning(or a particular version)
$ rails db:rollback VERSION=0


*reset the database*

drops the database and re-creates it
$ rails db:migrate:reset


*generate a resource*

$ rails g scaffold [Model-singular] [attribute]:[data_type] [attribute]:[data_type]

e.g User (Post, etc.)
$ rails g scaffold User name:string email:string


*add postgreSQL for production apps*

add the following to the Gemfile

```ruby
  group :production do
    gem 'pg', '0.20.0'
  end
```

When creating a new app, you can suppress the installation  of production gems with the `--without production` option

$ bundle install --without production

*enable ssl in production*

In `config/environments/production.rb`, uncomment

config.force_ssl = true

If the site's running on heroku, that's all that's required. If you have a custom domain, refer to their documentation [setup SSL on Heroku](https://devcenter.heroku.com/articles/ssl)


*seed the database with dummy data*

1. Add the gem `faker` to the `development` group of your Gemfile and run `bundle install`

2. add the following to the 'db/seed.rb' file:

```ruby
  User.create!(name:  "Example User",
               email: "example@railstutorial.org",
               password:              "foobar",
               password_confirmation: "foobar")

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password)
  end

```

3. reset, and then seed the database:


```bash
  rails db:migrate:reset
  rails db:seed
```


*use dummy data in your RSpec tests*

1. create a `fixtures` folder in '/spec'

2. create a yaml file in 'spec/fixtures' named after the database table you with to populate, e.g. `users.yml`

3. define you users in `users.yml`

```bash
michael:
  name: Michael Example
  email: michael@example.com
  password_digest: <%= User.digest('password') %>

archer:
  name: Sterling Archer
  email: duchess@example.gov
  password_digest: <%= User.digest('password') %>

lana:
  name: Lana Kane
  email: hands@example.gov
  password_digest: <%= User.digest('password') %>

malory:
  name: Malory Archer
  email: boss@example.gov
  password_digest: <%= User.digest('password') %>

<% 30.times do |n| %>
user_<%= n %>:
  name:  <%= "User #{n}" %>
  email: <%= "user-#{n}@example.com" %>
  password_digest: <%= User.digest('password') %>
<% end %>
```

4. in your spec file, add `fixtures :all`, you can access your users via the `users` method, addressing individual users via their 'label'  e.g.

```ruby
  @user = users(:michael)
```


### Erb

*link to*

<%= link_to([link_text], [route]) %>
<%= link_to("About page", '/about') %>  => <a href="/about">About page</a>

use route helpers so as not to hard code route string(append `_path`)
<%= link_to([link_text], [route_helper]) %>
<%= link_to("About page", about_path) %>  => <a href="/about">About page</a>


### Form Tags

1. form_tag

```bash
  <%= form_tag [action_path] do %>

  <% end %>
```

2. input field - adds id="post_title"

```bash
    <%= text_field_tag :'post[title]' %>
```

3. textarea field - adds id="post_description"

```bash
  <%= text_area_tag :'post[description]' %>
```

4. submit button/input - adds label "Submit Post"

```bash
    <%= submit_tag "Submit Post" %>
```



### Rake commands

display available rake commands
$ rake -T

display available routes
$ rake routes
