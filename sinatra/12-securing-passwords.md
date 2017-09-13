## Securing passwords

If your going to store user passwords on your system, make sure you hash them. 'Hashing' a password passes it through a hashing algorithm that converts it into a series of random characters which can not be converted back to your password. In addition you may add a 'salt' to the process - this is a random set of characters that is added to your hashed password. Not only does it make your password hash larger, and so more difficult to hack, but if two users were to use the same password, adding a salt ensures that the two hashes stored are different.

Hashing/salting a password stops a hacker from trying to decode your password, but does not stop a brute force attack - ensure that you implement a policy that locks out a users account after a set number of failed login attempts, enforces a password history, enforces a minimum password length, etc

### Implementing Password Encryption with Bcrypt

1. Bcrypt is a ruby gem that will create a salted, hashed version of your password and then store it in your database in the `password_digest` column. A basic ActiveRecord migration might look like:

```ruby
  # database migration class
  class CreateUsers < ActiveRecord::Migration[5.1]
    def change
      create_table :users do |t|
        t.string :username
        # name MUST be password_digest for has_secure_password to work with Bcrypt
        t.string :password_digest
      end
    end
  end
```

2. Ensure that the `User` model includes the ActiveRecord macro `has_secure_password` - works in conjunction with Bcrypt, adds a series of methods to the user model, e.g #authenticate, #password_confirmation, etc.

```ruby
  # User model
  class User < ActiveRecord::Base
  	has_secure_password
  end
```

3. Update the `post '/signup'` action - because the User model implements the `has_secure_password` - a user can not signup without providing a password, and so will be directed to the 'failure' page. If the user is saved, they're redirected to the 'login' page where they can login.

Note: Even though our database has a column called password_digest, we still use the attribute of `password`.

```ruby
  # signup controller
  post "/signup" do
      user = User.new(:username => params[:username], :password => params[:password])

      if user.save
          redirect "/login"
      else
          redirect "/failure"
      end
  end
```

4. Update the `post '/login'` action - check that a user with that username exists, and then check that the submitted password(params[:password]) matches the value in `password_digest` using the #authenticate method. If there's a match the user instance is returned, otherwise returns false.

```ruby
  post "/login" do
      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
          # we have a valid user, and they authenticated successfully
          session[:user_id] = user.id
          redirect "/success"
      else
          redirect "/failure"
      end
  end
```

### Resources

1. [Bcrypt](https://github.com/codahale/bcrypt-ruby)
2. [ActiveRecord has_secure_password](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)
