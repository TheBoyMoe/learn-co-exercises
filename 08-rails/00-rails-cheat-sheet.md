## Cheatsheet

### Rails

*generate a controller*

$ rails generate controller [controller_name] [action_name] ...

*undo/delete a controller*

$ rails destroy controller [controller_name]

*display routing table*

rails routes

*setting up a new Rails project with Rspec*

Create the rails app with the `new` keyword, adding the `-T` option to tell the generator not to include the default test framework `TestUnit`

$ rails new [app_name] -T

in the gem file add:
gem 'rspec-rails'

after running `bundle install`, create the initial RSpec config:
$ rails g rspec:install

*generate migration in rails*

$ rails generate migration [file_name]

*run the migration*

$ rails db:migrate


### Erb

*link to*

<%= link_to([link_text], [route]) %>
<%= link_to("About page", '/about') %>  => <a href="/about">About page</a>

use route helpers so as not to hard code route string(append `_path`)
<%= link_to([link_text], [route_helper]) %>
<%= link_to("About page", about_path) %>  => <a href="/about">About page</a>
