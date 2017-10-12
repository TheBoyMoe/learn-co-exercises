## Rack

Rack is a Ruby gem that allows you to create a simple web server.

### Setup

Create a class that has one method called #call. This method takes one argument - this is the request object(env) which holds all the request information, and returns a response object(Rack::Response object). The response consists of the status code, headers and body.

```ruby
  # application.rb
  require 'rack'

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


### The Request

Every http request has two parts, the header and the path to the path to the requested resource. All this information is found in the 'env' argument(a hash) passed to the #call method. Once we've converted this into a Rack Request obj, Rack has a number of methods that allows us to access this information.

```ruby
  class Application

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
      resp.finish
    end

  end
```

Somme Rack methods include:
  #path - returns the path requested
  #body - returns the body of the request
  #content_length/charset/type
  #cookies
  #port
  #query_string
  #url
  #request_method - the http verb




### The Response  

Every response must contain 3 parts, status, headers and body. You can use the Rack::Response class and it's convenience methods, e.g. write, set_cookie, finish etc. to create a response, or simply return an array containing the three components.

```ruby
class Application

  def call(env)
    [200, {'Content-Type' => 'text/html'}, ['Hello World']]
  end

end
```

status - http status code, e.g 200,404, etc
header - must respond to 'each' and yield key/value pairs, the keys have to be strings
body - data sent back to the requester. Has to respond to 'each' and yield string values.

### Simple Example

```ruby
  class Application

    # data to be shared
    @@items = ["Apples","Carrots","Pears"]

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      # the path that needs to be matched, http://localhost:9292/items
      if req.path.match(/items/)
        @@items.each do |item|
          resp.write "#{item}\n"
        end
      # match a search, e.g https://github.com/search?q=apples
      # the section after ? are the GET parameters, which come in a key/value pair  
      elsif req.path.match(/search/)

        # rack stores the key/value params as a hash
        search_term = req.params["q"]

        if @@items.include?(search_term)
          resp.write "#{search_term} is one of our items"
        else
          resp.write "Couldn't find #{search_term}"
        end

      else
        resp.write "Path Not Found"
      end

      resp.finish
    end
  end
```

### Dynamic Routes

Currently, for every new route (url path) we want to add to our server, we have to write an 'if' statement with a 'do' block our #call method. If our app handles user sign ups, allowing them to login and view account details, we couldn't be manually adding routes for each of these. In order to handle these situations we use dynamic routes.

Consider the following class and rack app:

```ruby
  #song.rb
  class Song
    attr_accessor :title, :artist
  end

  # application.rb ver. 1
  class Application

    @@songs = [Song.new("Sorry", "Justin Bieber"),
              Song.new("Hello","Adele")]

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      @@songs.each do |song|
        resp.write "#{song.title}\n"
      end

      resp.finish
    end
  end
```

In ver.1, all the song titles are returned no matter the path. If you want to query individual songs by path, e.g http://localhost:9292/songs/Sorry we could use ver.2, but would have to hard code each song individually, but this would be inflexible, requiring manual editing each time a song was added.

```ruby
  # application.rb ver.2
  class Application

    @@songs = [Song.new("Sorry", "Justin Bieber"),
              Song.new("Hello","Adele")]

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path == "/songs/Sorry"
        resp.write @@songs[0].artist
      elsif req.path == "/songs/Hello"
        resp.write @@songs[1].artist
      end

      resp.finish
    end
  end
```

Since paths are strings, we can look for the text after '/songs/' to determine the actual song and then look for a match, e.g. ver.3. Now we can add as many songs as req'd, and not have to edit our code.

```ruby
# application.rb ver.3
class Application

  @@songs = [Song.new("Sorry", "Justin Bieber"),
            Song.new("Hello","Adele")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/songs/)

      song_title = req.path.split("/songs/").last
      song = @@songs.find{|s| s.title == song_title}

      resp.write song.artist
    end

    resp.finish
  end
end
```

### Setting HTTP Status codes


Status Number | Code/Description
--------------|--------------------------
1             | 1xx: Informational (request received and continuing process)
2             | 2xx: Success (request successfully received, understood, and accepted)
3             | 3xx: Redirection (further action must be taken to complete request)
4             | 4xx: Client Error (request contains bad syntax and can't be completed)
5             | 5xx: Server Error (server couldn't complete request)


In rack you can set the status code through the status_code attribute, by default it is set to 200.


```ruby
  class Application

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path=="/songs"
        resp.write "You requested the songs"
      else
        resp.write "Route not found"
        resp.status = 404
      end

      resp.finish
    end
  end
```

### HTTP Verbs

Http verbs describe the required action. With the same resource we may want to update, delete or retrieve it.

VERB  | Description |
| ------------- | ------------- |
| HEAD  | Asks for a response like a GET but without the body  |
| GET  | Retrieves a representation of a resource  |
| POST | Submits data to be processed in the body of the request, e.g submitting a form|
| PUT | Uploads a representation of a resource in the body of the request |
| DELETE | Deletes a specific resource|
| TRACE | Echoes back the received request |
| OPTIONS | Returns the HTTP methods the server supports |
| CONNECT | Converts the request to a TCP/IP tunnel (generally for SSL)|
| PATCH | Apply a partial modification of a resource |


### Resources

1. [Rack docs](https://rack.github.io/)
2. [Overview of Rack](https://blog.engineyard.com/2015/understanding-rack-apps-and-middleware)
3. [Build a Rack Application from Scratch part 1](http://tommaso.pavese.me/2016/06/05/a-rack-application-from-scratch-part-1-introducting-rack/#a-naive-and-incomplete-framework)
4. [Build a Rack Application from Scratch part 2](http://tommaso.pavese.me/2016/07/26/a-rack-application-from-scratch-part-2-routes-and-controllers/)
5. [Build a Rack Application from Scratch part 3](http://tommaso.pavese.me/2016/08/01/a-rack-application-from-scratch-part-3-view-templates/)
6. [Build a Rack Application from Scratch part 4](http://tommaso.pavese.me/2016/10/09/a-rack-application-from-scratch-part-4-models-and-persistence/)
