# Devise

## Learning Objectives

1. Describe the major architecture and modules of Devise.
2. Build a working login system using Devise.

## Overview

[Devise] is a gem for when you have a lot of authentication needs.

Want to send confirmation emails, lock user accounts after a certain number of failed login attempts, and send password resets? Devise can do that.

Want to allow multiple models to be signed in, each with different roles, granting different permissions? Devise can handle that too.

Devise has an extensive collection of generators. It includes standard views and controllers. It will generate templates that include Bootstrap for you.

It will also be, at times, a giant pain because no magic is without a price. Devise abstracts away a lot of implementation details. That can be very nice, but it can also make it challenging to set up and debug when things don't go exactly to plan.

## Architecture

Devise is a Rails [engine]. That means it's basically a Rails app that sits inside your Rails app. It has its own views and controllers and defines its own routes.

It does not define models for you, but it does have generators that make the process of creating a Devise-compliant `User` model very easy.

Devise is made up of modules. Modules are applied to your `User` model, so you should read these as abilities that `User` accounts can have:
* **Database Authenticatable:** encrypts and stores a password in the database to validate the authenticity of a user while signing in. The authentication can be done both through `POST` requests or HTTP Basic Authentication.
* **Omniauthable:** adds [OmniAuth](https://github.com/intridea/omniauth) support.
* **Confirmable:** sends emails with confirmation instructions and verifies whether an account is already confirmed during sign in.
* **Recoverable:** resets the user password and sends reset instructions.
* **Registerable:** handles signing up users through a registration process, also allowing them to edit and destroy their account.
* **Rememberable:** manages generating and clearing a token for remembering the user from a saved cookie.
* **Trackable:** tracks sign in count, timestamps and IP address.
* **Timeoutable:** expires sessions that have not been active in a specified period of time.
* **Validatable:** provides validations of email and password. It's optional and can be customized, so you're able to define your own validations.
* **Lockable:** locks an account after a specified number of failed sign-in attempts. Can unlock via email or after a specified time period.

That's all from the [Devise docs][Devise].

## Configuration

Several of these modules come added for you by default if you run `rails generate devise User`. This generates a `User` model that includes some helpful notes at the top:

```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```

That's Devise wiring itself into the model. It also creates a migration for all the fields it needs.

Let's look at the highlights.

### [database_authenticable]

This adds a `valid_password?(password)` method to the model. The password is stored securely in the database.

### [registerable]

Registerable gives you `User.new_with_session(params, session)`, which lets you initialize a `User` from session data (like a token from Facebook) in addition to params.

### [recoverable]

Recoverable gives you password resets, like so:

```ruby
# resets the user password and save the record, true if valid passwords are given, otherwise false
User.find(1).reset_password('password123', 'password123')

# only resets the user password, without saving the record
user = User.find(1)
user.reset_password('password123', 'password123')

# creates a new token and sends it with instructions about how to reset the password
# (this one requires a mailer.)
User.find(1).send_reset_password_instructions
```

### [rememberable]

This lets you remember a user and associate them with a `User` object in the database without them having to log in. It works by storing a token in cookies.

```ruby
User.find(1).remember_me!  # regenerating the token
User.find(1).forget_me!    # clearing the token
```

### [trackable]

Track information about your user's sign-ins. It tracks the following columns:
* `sign_in_count` — Increased every time a user signs in (by form, OpenID, OAuth, etc.)
* `current_sign_in_at` — A timestamp updated when the user signs in
* `last_sign_in_at` — Holds the timestamp of the previous sign-in
* `current_sign_in_ip` — The remote IP updated when the user signs in
* `last_sign_in_ip` — Holds the remote IP of the previous sign-in

### [validatable]

The documentation on this is quite clear:

>Validatable creates all needed validations for a user email and password. It's optional, given you may want to create the validations by yourself. Automatically validate if the email is present, unique and its format is valid. Also tests presence of password, confirmation and length.

### [lockable]

Handles blocking a user's access after a certain number of attempts. Lockable accepts two different strategies to unlock a user after they're blocked: email and time. The former will send an email to the user when the lock happens, containing a link to unlock their account. The second will unlock the user automatically after some configured time (e.g., two hours). It's also possible to set up Lockable to use both email and time strategies.

### [omniauthable]
This one doesn't give you a whole lot more than OmniAuth already does. It does set some (but not all!) of the routes for you. That's a nice touch.

## Typical Setup
Add Devise to your Gemfile:
```ruby
gem 'devise'
```

Now run the installer:
```ruby
rails generate devise:install
```

This creates a massive initializer in `config/initializers/devise.rb`. This is probably the single best source of documentation for Devise. You'll want to look through it at some point.

You'll notice that the installer prints a big notice of several things you should do. In particular, we should have a root route.

Create a `WelcomeController` with a `#home` view and route.

Now generate your `User` model with:
```ruby
rails g devise User
```

Run `rake routes` and `rake db:migrate`. You should see that Devise has added a bunch of routes. Run `rails s` and take a look at one, such as `/users/sign_in`.

You should now have a working app with sign-in capability!

If you look at the routes you can see that Devise gives us a `sign_out` route as well. Let's implement that.

We probably want the user to be able to click 'Sign Out' on any page when they're logged in, so let's add that to our layout.

```erb
<!-- views/layouts/application.html.erb -->

  ...

  <%= link_to("Sign Out", destroy_user_session_path, :method => 'delete') %>

  ...
```

Devise will also add messages to the flash when a user signs in or when there's an error. We can add that to the layout as well so that those flash notices appear.

```erb
<!-- views/layouts/application.html.erb -->

  ...

  <%= content_tag(:div, flash[:error], :id => "flash_error") if flash[:error] %>
  <%= content_tag(:div, flash[:notice], :id => "flash_notice") if flash[:notice] %>
  <%= content_tag(:div, flash[:alert], :id => "flash_alert") if flash[:alert] %>

  ...
```

There's no navigation link for a user to get to the sign up page, so let's add one of those as well:
```erb
<!-- views/layouts/application.html.erb -->

  ...

  <%= link_to("Sign Up", new_user_registration_path) %>

  ...
```

## Conclusion

In a real app you'd probably want to add some CSS and probably put these pieces into partials, like a header or nav partial, but you can see how quickly and with how little code we were able to get a fully functioning login system. Feel free to play around with the other Devise modules!

## Resources
* [How to use Devise](https://launchschool.com/blog/how-to-use-devise-in-rails-for-authentication)
* [Devise][Devise]
* [engine][engine]
* [registerable], [database_authenticable], [recoverable], [rememberable], [trackable], [validatable], [lockable], [omniauthable]

[Devise]: https://github.com/plataformatec/devise
[engine]: http://guides.rubyonrails.org/engines.html
[registerable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Registerable
[database_authenticable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/DatabaseAuthenticatable
[recoverable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Recoverable
[rememberable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Rememberable
[trackable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Trackable
[validatable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Validatable
[lockable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Lockable
[omniauthable]: http://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Omniauthable
