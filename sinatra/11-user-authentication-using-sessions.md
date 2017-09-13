## User Authentication using Sessions

### Logging In

Logging in is the action of storing a user's ID in the `session` hash. A typical user login flow:

1. User fills out a login form with their email and password and hits 'submit' - `POST`s that data to a controller route specified in the form's 'action'.

2. That controller route accesses the user's email and password from the `params` hash finds the appropriate user from the database and stores that user's id in the session hash, e.g,

```ruby
  user = User.find_by(email: params[:email], password: params[:password])

  session[:id] = user.id
```

3. The `session` hash is available in every other controller route (and views??). That means that, for the duration of the session (i.e., until the user logs out), the app will know who the current user is on every page by matching up a user ID with the `session[:id]` value.

Note: in this particular example encryption of users passwords will be ignored, and they will be stored in plain text in the database.


### Logging Out

Logging out is the terminating of the user's session, this is carried out by simply clearing all the data from the `session` hash, including the user's ID - use the ruby `#clear` method.

### User Registration / Sign Up

Required before a user can login in, provide a form where a user can provide a name/email and password as a minimum. When the form is submitted via a 'post' request, the controller action specified in the form will carry out the following:

1. Retrieve the user's info from the `params` hash.

2. Use that info to create and save a new instance of `User`.

```ruby
  User.create(name: params[:name], email: params[:email], password: params[:password])
```

3. Sign the user in automatically. In the same controller route in which we create a new user, we set the `session[:id]` equal to the new user's ID, effectively logging them in.

4. Finally, we redirect the user somewhere else, e.g. their personal homepage.


### Typical App Structure

```bash
  # there are separate view sub-folders to correspond to the different controller action groupings.
  -app
    |- controllers
        |- application_controller.rb
    |- models
        |- user.rb
    |- views
        |- home.erb
        |- registrations
            |- signup.erb
        |- sessions
            |- login.erb
        |- users
            |- home.erb
  -config
  -db
  -spec
  ...
```

#### The Application Controller

A basic ApplicationController would have the following routes:

* `get '/registrations/signup'` route responsible for rendering the sign-up form view found in `app/views/registrations/signup.erb`.

* `post '/registrations'` route is responsible for handling the `POST` request that is sent when a user hits 'submit' on the sign-up form. The controller action will retrieve the user's info from the `params` hash, creates a new user, signs them in, and then redirects them somewhere else.

* `get '/sessions/login'` route is responsible for rendering the login form, sends form submissions to the `post '/sessions'` route.

* `post '/sessions'` route is responsible for receiving the `POST` request that gets sent when a user hits 'submit' on the login form. The controller action retrieves the user's info from the `params` hash, looks to match that info against the existing entries in the user database, and, if a matching entry is found, signs the user in.

* `get '/sessions/logout'` route is responsible for logging the user out by clearing the `session` hash.

* `get '/users/home'` route is responsible for rendering the user's homepage view.


### The User Model

Found in `app/models/user.rb`, we'll use active record to ensure that a user can not register/signup without providing a name, email and password

```ruby
  class User < ActiveRecord::Base
    # ensures that no one can signup without inputting a name, email and password
    validates_presence_of :name, :email, :password
  end
```

### the Views folder

Create the view folders' structure to match that of the different controllers, e.g.

* **`views/registrations`** sub-directory contains the template for the new user sign-up form that is rendered by the `get '/registrations/signup'` route. This form will `POST` to the `post '/registrations'` route.

* **`views/sessions`** sub-directory contains the template for the login form that is rendered by the `get '/sessions/login'` route. This form sends a `POST` request that is handled by the `post '/sessions'` route.

* **`views/users`** sub-directory contains the template that renders the user's homepage. This page is rendered by the `get '/users/home'` route.

* The `home.erb` file in the top level of the `views` directory. This is the page rendered by the root route, `get '/'`.


### Summary

* Separate out your views into sub-folders according to their different concerns / controller routes.

* Signing up for an app is nothing more than submitting a form, grabbing data from the `params` hash, and using it to create a new user.

* Logging in is nothing more than locating the correct user and setting the `:id` key in the `session` hash equal to their user ID.

* Logging out is accomplished by clearing all of the data from the `session` hash.
