class User < ActiveRecord::Base
  has_secure_password
  has_many :posts

  # has_secure_password is a macro which adds 5 new methods to the User instance

  # 1. user.authenticate() -> check if valid user password, returns user instance or false

  # 2. user.password= -> set the password

  # 3. user.password_digest -> returns the hashed password

  # 4. user.password_confirmation -> ??

end
