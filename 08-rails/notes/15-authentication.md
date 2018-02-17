## Authentication

### Cookies and Sessions

**Cookies**
- are used by clients to store information about the current session locally
- a http session is stateless, the server does not 'remember' the user, so the cookie is sent with each subsequent request
- primarily used for login, they provide a way to verify the user for the entire session(otherwise you would have to provide your credentials every request)
- can also be used to store info about the user, e.g. contents of a cart, what ads they've been shown
- although cookies are stored in the browser in plain text, in Rails any key/value pairs saved to a `session` are serialized to a string which is then cryptographically signed when the cookie is set preventing it from being read or tampered with.
- Rails allows you to save any simple Ruby object to the session, wheich is available anywhere in the response cycle 
	

**Rails session**
- is a data store that can be used to store numbers, strings, arrays(of numbers and strings) and hashes that is persisted between requests.
- use the `session` method to manipulate the session store
- the session is only available in the controller and view(use a helper method)
- there a three different mechanisms for implementing a session store:
	* ActionDispatch::Session::CookieStore - Stores everything on the client.
		- default and recommended, requires zero setup in order to use a session in a new app
		- the ID and data is all stored in the cookie
		- can store upto 4KB of data
	* ActionDispatch::Session::CacheStore - Stores the data in the Rails cache.
		- for info that is not critical, or does not need to be around for long, e.g. flash messages
	* ActionDispatch::Session::ActiveRecordStore - Stores the data in a database using Active Record(require activerecord-session_store gem).
- The Cache and ActiveRecord session stores use a cookie to store a unique ID for each session
- You must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure.

You can define the particular mechanism in `config/initializer/session_store.rb`

```ruby
Rails.application.config.session_store :cookie_store, key: '_your_app_key'


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails g active_record:session_migration")

# Rails.application.config.session_store :active_record_store
```

Rails defines the secret key to cryptographically sign session data for the CookieStore in `config/secrets.yml`