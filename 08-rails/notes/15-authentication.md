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


### Session Controller and Login in Rails

Typical flow is:

 * The user GETs `/login`
 * The user enters their username(no password in this example).
 * The user submits the form, POSTing to `/login`.
 * In the create action of the `SessionsController` we set a cookie on the user's browser by writing their username into the session hash.
 * Thereafter, the user is logged in. `session[:username]` will hold their username.
 
```ruby
# app/controllers/session_controller.rb
class SessionsController < ApplicationController

	# GET 'login'
	def new
		# render the login form
	end

	# POST 'login'
	def create
		if params[:username].nil? || params[:username].empty?
			redirect_to new_session_path
		else
			session[:username] = params[:username]
			redirect_to homepage_path
		end
	end
	
	# POST 'logout'
	def destroy
    session.delete :username
    redirect_to new_session_path
  end
end 
``` 


```html
<!--spp/views/sessions/new.html.erb-->
<h1>Login</h1>

<%= form_tag sessions_path, method: 'post' do %>

	<label for="username">Username</label>
	<%= text_field_tag :username %>

	<%= submit_tag 'Login' %>
<% end %>
```

### Securing Passwords in Rails

Rails provides the `has_secure_password` method - requires the `bcrypt` gem.
	* adds two fields to your user model, `password` and `password_confirmation`
	* these two fields DO NOT correspond to columns in the database, instead you need to define a `password_digest` column in your migration
	* it also adds some `before_save` hooks to the User model which compare the `password` and `password_confirmation` fields and update the `password_digest` column.


```html
<!--app/views/user/new.html.erb-->
<%= form_for :user, url: '/users' do |f| %>
  <%= f.label 'Username' %> 
  <%= f.text_field :username %>
  
  <%= f.label 'Password' %>
  <%= f.password_field :password %>
  
  <%= f.label 'Password_confirmation' %>
  <%= f.password_field :password_confirmation %>
  
  <%= f.submit "Submit" %>
<% end %>
```

```ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
	# user signup, also need to add the user id to the session
  def create
    user = User.new(user_params).save
  end
 
  private
 
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end


# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    return head(:forbidden) unless @user.authenticate(params[:password])
    session[:user_id] = @user.id
  end
end


# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
end
```


### Omniauth, Devise and 3rd Party Authentication

The OmniAuth gem `omniauth-google` supports user signin using the OAuth protocol with 3rd party providers such a s Twitter, Facebook, Google, etc - simply add the gem to your project and include the provider specific strategy.

A typical OmniAuth signup process:
  1. User tries to access a page on `yoursite.com` that requires them to be logged in. They are redirected to the login screen.
  2. The login screen offers the options of creating an account or logging in with Google or Twitter.
  3. The user clicks `Log in with Google`. This momentarily sends the user to `yoursite.com/auth/google`, which quickly redirects to the Google sign-in page.
  4. If the user is not already signed in to Google, they sign in normally. More likely, they are already signed in, so Google simply asks if it's okay to let `yoursite.com` access the user's information. The user agrees.
  5. They are (hopefully quickly) redirected to `yoursite.com/auth/google/callback` and, from there, to the page they initially tried to access.
  

To setup Facebook:

1. Logon to the Facebook developer site, create an app. Make note of the 'FACEBOOK_KEY' and 'FACEBOOK_SECRET VALUES' and set the callback url, e.g. `localhost:3000/auth/facebook/callback`.

2. Add the `dotenv-rails`, `omniauth` and `omniauth-facebook` gems and run bundle.

3. Create a `.env` at the root of your app(adding it to .gitignore), and add your Facebook credentials


```text
FACEBOOK_KEY=xxxxxxxxxxxxxx
FACEBOOK_SECRET=xxxxxxxxxxxxxxx
```

3. Add the following file, `config/initializers/omniauth.rb` - and reference the providers credentials for your app

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end
```

4. Add a link to your login page allowing users to signin - the std omniauth path is `/auth/:provider`


```html
<%= link_to('Log in with Facebook!', '/auth/facebook') %>
``` 

5. Create a User model with a name, email, image and uid attributes, all strings.

6. Create a basic SessionController to handle user logins


```ruby
class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
 
    session[:user_id] = @user.id
 
    render 'welcome/home'
  end
 
  private
 
  def auth
    request.env['omniauth.auth']
  end
end
```


7. Add a route to the routing table - if authentication succeeds we'll be redirected to the `Session#create` action via the callback route. The create action gives you access to the hash object returned by the provider which will contain the user's name, email, image link(possible), etc. Typically, if a matching User exists in your database, the client will be logged in to your application. If no match is found, a new User will be created using the data received from the provider.

Note:  If authentication fails, we'll also be redirected to our server's OmniAuth callback route. The hash object received contains a series of error parameters that provide information about the failure such as error code/description etc.


```ruby
get '/auth/facebook/callback' => 'sessions#create'
```

8. Finally, `app/views/static/home`, will display the user's details or the link to login, depending on whether the user has logged in.


```html
<% if session[:user_id] %>
  <h1><%= @user.name %></h1>
  <h2>Email: <%= @user.email %></h2>
  <h2>Facebook UID: <%= @user.uid %></h2>
  <img src="<%= @user.image %>">
<% else %>
  <%= link_to('Log in with Facebook!', '/auth/facebook') %>
<% end %>
```


### Authentication using the Devise gem

Devise is a ruby gem that provides both authentication and authorisation(through roles). It includes views, controllers and routes.
It also supports the following features through various modules
- sends out confirmation emails
- supports account lockout after a certain number of failed logon attempts
- allows users to reset passwords
- supports 3rd party auth through the omniauthable module
- remembers users through cookies(manages the generating and clearing of tokens - the token is stored in the cookie)
- can timeout a user session that has been inactive for a set period of time
- can track a user's sign in's, their ip, number of sign ins, last sign in, current sign in. 

Several of these modules are enabled by default:

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```

Note: generate the User model through the Devise generator

```ruby
rails generate devise User name:string
```

### Devise and Facebook Strategy Setup

1. Add the following gems

```ruby
gem 'devise', '~> 4.4', '>= 4.4.1'
gem 'dotenv-rails', '~> 2.2', '>= 2.2.1'
gem 'omniauth', '~> 1.8', '>= 1.8.1'
gem 'omniauth-facebook', '~> 4.0'
```

2. run the devise install generator

```ruby
rails generate devise:install
```

3. add the following line to `config/environments/development.rb`

```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

4. Define a static route, controller action and template where users are redirected to following signup/login

5. Add the following flash messages to `app/views/layouts/application.html.erb`

```html
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>
```

(Optionally) You can define custom devise error messages using a devise helper that will display flash messages which include bootstrap classes

```ruby
# app/helpers/devise_helper.rb
module DeviseHelper
	def devise_error_messages!
		return '' if resource.errors.empty?

		messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
		html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
      <strong>
       #{pluralize(resource.errors.count, "error")} must be fixed
      </strong>
      #{messages}
    </div>
		HTML

		html.html_safe
	end

	def devise_error_messages?
		!resource.errors.empty?
	end
end
```

6. generate the User model and run the migrations - adds the user sign in, sign out, registration routes, etc.  

```ruby
rails g devise User
```

7. generate the devise views

```ruby
rails generate devise:views
```

Additional Customisation

8. Install Bootstrap 3

- add the following gems

```ruby
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
```

- rename `app/assets/stylesheets/application.css` to the `.scss` ext.
- delete it's contents and add

```scss
/*
 *= require main
 */
```

- create `main.scss` in `app/assets/stylesheets` and import your stylesheets through it, e.g.

```scss
// Global site styles
@import "bootstrap-sprockets";
@import "bootstrap";

// Base assets
//@import "base/mixins";
//@import "base/variables";


// Plugins
//@import "plugins/font-awesome";
```

- reference the req'd js files in `app/assets/javascripts/application.js`

```javascript 1.6

```
