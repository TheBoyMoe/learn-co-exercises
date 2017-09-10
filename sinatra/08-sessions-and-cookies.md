## Sessions and Cookies

Http is a stateless protocol, each request is an independent transaction and thus unable to use information of previous requests. In order to track what page a user is on, what items are in their cart, or whether a user is logged in and return them back to the same page we rely on a combination of cookies and sessions:
  - Cookies are hashes that store data, sent by the server regarding the http request, in the client browser as a text file. Each request the server sends information to the client, in each subsequent request the client sends the cookie is sent back to the server. They're visible only to the server that created them.
  - Sessions are hashes that store data about a client's interactions with a web page at a particular moment in time that are stored on the server side.

A web server will use cookies and session data to keep track of a client's interaction with a particular site. When you send a request to facebook.com, the application on the server will generate and store some data about you. The application will keep that data in a session hash, and it will also create a cookie that is sent back to the client and stored in their browser. These persist until they expire or are deleted. Upon any subsequent visits to the same website, the cookies are sent back. At that pint the cookie data is compared to the server-side session data(if it exists) and decides how to respond.


### Cookies

Cookies will contain:
  - the website's url
  - date created, and expiry
  - any info pertinent the the particular site the server wants saved, e.g. user preferences, login information.

There are two types:

**Session cookies** allow the server to keep track of your movement from page to page on that particular visit. Once logged in, a session cookie allows you to navigate through a site without to having to repeatedly authenticate on every new page you visit within the web application domain. Session cookies expire every time you log out or navigate away from the website.

Without a session cookie if you were to add an item to your cart, you you were to then navigate to any other page, that that information would be lost.

**Persistent cookies** are used to store user preferences and information for future visits, such as usernames to to enable speeder authentication, and user preferences. They're used to improve the user's experience of using the site.

A persistent cookie is stored on your computer, while a session cookie is temporarily stored in your web browser. They're typically created on the first visit, after you have created an account on the site, and typically persist unless either the web application has a protocol in place for cookie expiration or the user clears their browser's cache.


### Sessions

A session is just a hash that stores data on the server, passing that data to the user as a cookie. You can access the data just like any other hash. The session hash can be accessed in any controller file of your application. Whatever data is stored in the session hash can thus be accessed, added to, changed or deleted in any controller file or route at any time and that change persists for the duration of the session - the period of time in which you, the client, are interacting with the web application. This is usually the time in between logging in and logging out. The act of logging in/out is simply the act of having your `user_id` added to or removed from the session hash. The session hash can be used to store anything, including the user's profile page, shopping cart, etc. The session hash can be accessed and manipulated across http requests from any controller - changes made in one controller route will persist across http requests to be available in other controller routes.

The session is simply a way to store user data on a temporary basis. In any web application, a user ID is typically used as a session ID - the ID attribute of a user is a unique identifier that will always be distinguishable from other user ID attributes.

1. Setup

In Sinatra you enable sessions within the controller, e.g. 'app.rb', in the 'configure' block.

```ruby
  configure do
    # turn sessions on, every controller has access to the session hash
    enable :sessions
    # sets the encryption key used to create a session_id
    set :session_secret, "secret"
  end
```

You can set the `session_secret` to anything you want. It's a basic security feature designed to make it harder for someone to hack into your site without either signing up or signing in. A `session_id` is a alphanumeric string that is unique to a given user's session, is used to encrypt the session hash and is stored in the browser cookie.

2. Using

To track a user throughout through the current visit, we need to set up the `session` hash to store the `user_id` - available once you've logged in to a site. You can modify and add data to the session hash by adding a key-value pair.

```ruby
  get '/' do
    session["name"] = "Victoria"
    # gets a reference to the session hash, making it visible to our views
    @session = session
  end

  # example of a session hash
  @session = {
    "session_id"=>  
      "dd32f512ee239ad74aa6f10c8cad37ce28d6c6922eff252ed641b1017130fe22",
    "csrf"=> "040e9777d4dfae03bb1e6498f2a75482",
    "tracking"=>{
      "HTTP_USER_AGENT"=> "e193e9e937caa9a19ca483f046281aae77d2216b",
      "HTTP_ACCEPT_LANGUAGE"=> "66eae971492938c2dcc2fb1ddc8d7ec3196037da"
    }
  }
```

3. Viewing

You can view the contents of the session hash as a cookie in your browser using the Developer Tools. Visit any site that requires a login. Once authenticated, in Chrome open Developer Tools > `Application` tab, `Storage` section,  select the `Cookies` dropdown and click on the cookie with the matching url of the current site. You'll see a list of cookies from the site, a few will say `Session` - in the `Expires/Max-Age` column. One of these will be the cookie used to keep track of the session.

4. Clearing

There are a number of ways:

  - all sessions cookies are automatically cleared when you log out of the site.

  - you can clear session cookies using the Developer Tools - right-click on the url in the `Cookies` dropdown and select clear. If you now refresh the page you'll find that you've been logged out.

  - in Your `/logout` route you clear out the session by setting it's value to an empty hash, e.g session = {}. Any key-value pairs you add during the session will persist until the session is cleared.

Incognito mode in Chrome does not persist any cookies, session or persistent. Cookies are created for that particular session and then cleared when the session is over. Incognito mode can thus be useful to debug session and cookie problems.
