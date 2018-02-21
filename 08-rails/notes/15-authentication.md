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


### User Authentication with Devise

Devise is a ruby gem that provides both authentication and authorisation(through roles). It includes views, controllers and routes.
It also supports the following features through various modules
- sends out confirmation emails
- supports account lockout after a certain number of failed logon attempts
- allows users to reset passwords
- supports 3rd party auth through the omniauthable module
- remembers users through cookies(manages the generating and clearing of tokens - the token is stored in the cookie)
- can timeout a user session that has been inactive for a set period of time
- can track a user's sign in's, their ip, number of sign ins, last sign in, current sign in. 

Several of these modules are enabled by default once you've generated the User model through the devise generator:

```ruby
rails generate devise User name:string
```


```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```

Check the devise-email-facebook-demo in the Sandbox repo for a working version


### User Authorisation with Devise

Devise supports user authorisation, what users are allowed to do, through the use of roles.

1. Define the required role's in the User model through the use of an enum(not the only way!).

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?
  
  private
    def set_default_role
      self.role ||= :user
    end
      
end
```

Enums are stored in the database as integers, add a `role` column to the users table with a datatype of integer and run the migrations

```ruby
rails g migration AddRoleToUsers role:integer

# creates the following migration
class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer
  end
end
```


This gives you a number of useful methods:

```ruby
user.admin? # true/false
user.admin! # sets the role to 'admin'
user.role = 1 
# user.role => 'vip'
user.role = :admin
# user.role #=> 'admin'
```

2. Define filters in your controllers which define what various roles can do to that particular object

```ruby
class PostsController < ApplicationController
  def update
    @post = Post.find(params[:id])
    return head(:forbidden) unless current_user.admin? ||
          current_user.moderator? || current_user.try(:id) == @post.owner_id
    @post.update(post_params)
  end
  # more down here
end
```

`current_user.try(:id) == @post.owner_id` ensures that the current user is not a guest, i.e. is logged in and the owner of the post


### Using Devise with Pundit to implement User Authorisation

Using Devise roles to filter what users are authorised to do/access in controllers works in simple apps, where users have clear cut roles and users do not share those roles.

The [CanCanCan](https://github.com/CanCanCommunity/cancancan) gem is an authorisation library which implements user permissions which are checked in the app's controllers. This works fine in simple apps.

The [Pundit](https://github.com/varvet/pundit) gem is focused around the notion of defining a policy class for a particular model, e.g. PostPolicy, in which you define the particular authorisation rules that users can perform with that model. This provides a modular way to separate authorisation logic from both your controllers and models. You can use Devise roles to define the different types of users, e.g. admin, editor, user, etc.

To install Pundit, add the gem and include a reference to Pundit in the `ApplicationController`

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
	include Pundit  # add this line
	protect_from_forgery
end
```

and run the generator

```ruby
bundle exec rails g pundit:install
```


Policies are named after the model, e.g. <model>Policy, and saved in the `app/policies` folder

```ruby
# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
  	#  admins and moderators can update any post, and users who are neither of those things can update only posts they own
		user.admin? || user.moderator? || record.try(:user) == user
	end
end
```

`record` is the name for the model object. It is set in the ApplicationPolicy generated by the installer, and can be changed in your policy class by overriding the initializer:


```ruby
class PostPolicy < ApplicationPolicy
	attr_reader :post
	
	def initialize(user, post)
		super(user, post)
		@post = record
	end
	
	def update?
		user.admin? || user.moderator? || post.try(:user) == user
	end
end
```

To apply the policy, call `authorize` in the particular controller action

```ruby
class PostsController < ApplicationController
	def update
		@post = Post.find(params[:id])
		authorize @post
	end
end
```

By default, authorize calls the policy method of the same name as your controller action with a question mark after it, which is equivalent to:
 
```ruby
PostPolicy.new(current_user, @post).update?
```


Pundit also offers `helpers` (which can be used in views), e.g.

```html
<% if policy(@post).update? %>
	<%= link_to "Edit post", edit_post_path(@post) %>
<% end %>
```

```ruby
policy(@post)
# is equivalent to
PostPolicy.new(current_user, @post) 
```

**Testing**  

It's also straightforward to write unit tests that will check our authorisation rules, simply pass in the model objects and assert that the correct action occurs, e.g.

```ruby
class PostPolicyTest
	test "users can't update others posts" do
		amethyst = users(:amethyst)
		post = posts(:garnet_private)
		expect(post.user).not_to eq(amethyst)
		expect(PostPolicy.new(amethyst, post).update?).to be false
	end
end
```

**Permitted Parameters**  

Pundit allows you to control what attributes of a model a user can update through the `permitted_attributes` method


```ruby
class PostPolicy < ApplicationPolicy
	def permitted_attributes
		# users can update an post tag, but only admins or the posts's owner can update the title or body
		if user.admin? || user.owner_of?(post)
			[:title, :body, :tag_list]
		else
			[:tag_list]
		end
	end
end


class PostsController
	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(permitted_attributes(@post))
			redirect_to @post
		else
			render :edit
		end
	end
end
```

Pundit allows us to use `permitted_attributes` as a helper in controllers, it takes the model and returns which attributes are writable.


**Scope**  

Is a feature of Pundit that allows you to return the result of a sql query to certain users, e.g. in a blog where you have both published and draft posts, you may choose to show only published and draft posts to admin users. You define a class named Scope, which inherits from Scope, inside your policy. 

```ruby
class PostPolicy < ApplicationPolicy

 class Scope < Scope
	 def resolve
		 if user.admin?
			 scope.all
		 else
			 scope.where(:published => true)
		 end
	 end
 end
 
 # ... more
end
```


The Scope class initializes with a user and a scope, which is an ActiveRecord::Relation - lets you chain the policy with your queries, e.g. I can query for all the posts on a particular topic which only I can see - which you can do in a view like so:

```html
<% policy_scope(@user.posts).each do |post| %>
	<p><%= link_to post.title, post_path(post) %></p>
<% end %>
```