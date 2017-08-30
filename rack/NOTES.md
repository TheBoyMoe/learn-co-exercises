## Rack

Rack is a Ruby gem that allows you to create a simple web server.

Setup

Create a class that has one method called #call. This method takes one argument - this is the request object(env) which holds all the request information, and returns a response object(Rack::Response object). The response consists of the status code, headers and body.

```ruby
  # application.rb

  class Application

    def call(env)
      resp = Rack::Response.new
      resp.write "Hello, World"
      resp.finish
    end

  end
```

To run the server, we need a config.ru file and then use the 'rackup' command to start everything.

```ruby
  # config.ru
  require_relative "./application.rb"

  run Application.new

  # from the command prompt
  rackup config.ru
```
