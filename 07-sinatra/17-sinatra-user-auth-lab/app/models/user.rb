class User < ActiveRecord::Base
  # ensures that no one can signup without inputting a name, email and password
  validates_presence_of :name, :email, :password
end
