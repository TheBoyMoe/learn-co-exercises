## Sinatra

Sinatra is a Domain Specific Language implemented in Ruby that's used for writing web applications. Created by Blake Mizerany, Sinatra is Rack-based, which means it can fit into any Rack-based application stack, including Rails.

Unlike Ruby on Rails, which is a Full Stack Web Development Framework that provides everything needed from front to back, Sinatra is designed to be lightweight and flexible. Sinatra is designed to provide you with the bare minimum requirements and abstractions for building simple and dynamic Ruby web applications.

Sinatra is considered a light weight framework where the responsibility of app structure and communication falls solely on the developer. Sinatra doesn't give you a lot to get started with. There is no way to auto-generate files, directories or routes. Sinatra requires that you create the app structure, routes, controllers and connect them manually.

To get started install the sinatra gem, 'gem install sinatra'.

Starting with an empty dir, create app, config folders. In app/, add models, views and controllers folders - adding application.rb to the controllers dir. Add environment.rb to config/. From the cli, enter 'bundle init', to create your Gemfile and add the 'sinatra' and 'rspec' gems. The 'bundle install' command will download these, plus create you 'Gemfile.lock' file. Run 'rspec --init', creates your 'spec' folder, 'spec_helper.rb' and '.rspec' files. Add 'config.ru' file to the root of the project - entry point for the app.

The application controller (app/controllers/application.rb) is the heart of the app. This class inherits from Sinatra::Base - giving it Sinatra's functionality, i.e. you're turning an ordinary ruby class in to a class that knows how to handle web requests. To start the app enter 'rackup config.ru'  or simply 'rackup'. Load the 'shotgun' gem (install the gem 'gem install shotgun' so the command is available from the cli, and add it to the gem file and download with 'bundle install') and start the app with 'shotgun config.ru' (or 'shotgun'), instead of rackup and any changes to the app are automatically applied without a re-start. Shotgun uses port 9393, as opposed to 9292. When starting an app with rackup, the application code is read once - every start thus requires a re-start

'config.ru' requires a Sinatra Controller to run- a ruby class that inherits from Sinatra::Base. This gives the app a Rack-compatible interface via the Sinatra framework. Within controllers we define our 'routes' or methods such as 'get', and 'post'. These methods are attached to and scoped to the particular controller they're defined in. The final step in creating a route is to 'mount' it in the config.ru file. The 'application' controller is mounted using the 'run' keyword. All other controllers are mounted using the 'use' keyword.


### Routes

A route connects a http request to a specific resource on your server via a specific method in your controllers - the actual code within the method is the 'Controller Action'. The resource part of the url, e.g. '/cart', '/songs' is mapped to a particular method that is executed in response, e.g display the customers shopping cart. Each route will respond to a particular http verb, e.g. 'get', or 'post' and a string that matches the resource path, e.g. 'http://localhost:9393/medicines' will be interpreted as a 'GET' request for '/medicines'.

```ruby
  # route / controller action
  get '/medicines' do
    # do something
  end

  # or
  get('/medicines') { # do something }
```

**dynamic routes:** routes that are created based on attributes within the url of the request. A route such as 'get /posts/:id' or 'get /users/:name' which has a ':' in front of a variable is a dynamic route. Such routes allow us to take input directly from a url, e.g. the :name or :id, and generate countless routes to resources on the fly dynamically without having to hard code them. A route is simply a html verb, e.g. 'get', that is paired with a matching url pattern.

The url parameters entered by the user will be accessible within the controller action through the automatically generated params hash. The hash will contain a key-value pair for each parameter specified in the url. Thus, '/posts/:id', will generate a hash with a key of ':id', the value being that entered by the user.  

You can receive multiple pieces of data through a dynamic route by separating the content with a forward slash. For example, get '/numbers/:number1/:number2' would give you a params hash with two key-value pairs (number1 and number2).

**unsafe characters in urls** certain characters are not allowed in urls, e.g. spaces are replaced by '%20'. Unsafe characters will be encoded with appropriate ASCII characters.  


### Passing variables between Views and Controllers

Instance variables defined in a class are visible throughout the instance, and accessible by any instance method. Creating an instance variable in a controller method/route makes that variable visible in the erb template that controller renders. It is, however not visible in other controllers. Using instance variables in this way allows us to create dynamic pages - we can insert data from database requests, an api, a calculation, etc.

```erb
# controller route
  post '/reverse' do
    original_string = params["string"]
    @reversed_string = original_string.reverse

    erb :reversed
  end

  # reversed.erb template

  # we can access the instance variable in the template
  <p><%= @reversed_string %></p>
```

Using instance variables in controllers is also the way in which we can pass an array to a template,  which we can iterate through and render.

```erb
  get '/friends' do
    @friends = ['Emily Wilding Davison', 'Harriet Tubman', 'Joan of Arc', 'Malala Yousafzai', 'Sojourner Truth']

    erb :friends
  end

  # friends.erb
  <ul>
    <% @friends.each do |friend| %>
    <li><%= friend %></li>
    <% end %>
  </ul>
```

### Resources

1. [Getting started with Sinatra](http://www.sinatrarb.com/intro.html)
2. [URL Encoded Characters](http://www.degraeve.com/reference/urlencoding.php)
