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
	* ActionDispatch::Session::CookieStore 
		- default and recommended, it requires zero setup in order to use a session in a new app
		- stores everything on the client, the ID and data is all stored in the cookie
		- can store upto 4KB of data
	* ActionDispatch::Session::CacheStore 
		- stores data in the Rails cache.
		- for info that is not critical, or does not need to be around for long, e.g. flash messages
	* ActionDispatch::Session::ActiveRecordStore 
		- stores the data in a database using Active Record(requires activerecord-session_store gem).
		- both Cache and ActiveRecord session store's use a cookie to store the ID of each session
		- you must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure.

You can define the particular mechanism in `config/initializer/session_store.rb`

```ruby
Rails.application.config.session_store :cookie_store, key: '_your_app_key'


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails g active_record:session_migration")

# Rails.application.config.session_store :active_record_store
```

Rails defines the secret key to cryptographically sign session data for the CookieStore in `config/secrets.yml`

To access the session use the Rails `session` method. The session is lazy loaded, so you don't need to disable it if you don't access it. To reset the entire session, use `reset_session`.

```ruby
class ApplicationController < ActionController::Base
 
  private
		# Finds the User with the ID stored in the session with the key
		# :current_user_id This is a common way to handle user login in
		# a Rails application; logging in sets the session value and
		# logging out removes it.
		def current_user
			@current_user ||= session[:current_user_id] &&
				User.find_by(id: session[:current_user_id])
		end
end


class LoginsController < ApplicationController
  # "Create" a login, aka "log the user in"
  def create
    if user = User.authenticate(params[:username], params[:password])
      # Save the user ID in the session so it can be used in subsequent requests
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end
  
  # "Delete" a login, aka "log the user out"
	def destroy
		# Remove the user id from the session
		@current_user = session[:current_user_id] = nil
		redirect_to root_url
	end
end
```
