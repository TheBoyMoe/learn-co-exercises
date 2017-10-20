## Cheatsheet

### Rails

*generate a controller*

$ rails generate controller [controller_name] [action_name] ...

*undo/delete a controller*

$ rails destroy controller [controller_name]

*display routing table*

rails routes

*setting up a new Rails project with Rspec*

Create the rails app with the `new` keyword, adding the `-T` option to tell the generator not to include the default test framework `TestUnit`, add `--without production` to stop the installation of production gems,

$ rails new [app_name] -T --without production

in the gem file add:
gem 'rspec-rails'

after running `bundle install`, create the initial RSpec config:
$ rails g rspec:install

*generate migration in rails*

$ rails generate migration [file_name]

*run the migration*

$ rails db:migrate


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
