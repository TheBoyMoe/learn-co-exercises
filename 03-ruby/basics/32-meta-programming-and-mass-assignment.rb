# keyword arguments - metaprogramming and mass Assignment
# scenario - pull user data from the Twitter Api which returns a has of user attributes
class User
  attr_reader :user_name, :name, :age, :location

  # class initializes with keyword arguments - i.e, we can use a hash of attributes
  def initialize(user_name:, name:, age:, location:)
    @user_name = user_name
    @name = name
    @age = age
    @location = location
  end
end

# returned twitter user info - which can be used to instantiate a user obj
user = {name: "Sophie", user_name: "sm_debenedetto", age: 26, location: "NY, NY"}
sophie = User.new(user)
puts sophie

# if twitter should change their api, ie add or remove attributes from the returned hash
# twitter_user = {name: "Sophie", user_name: "sm_debenedetto", location: "NY, NY"}
# User.new(twitter_user) #=> ArgumentError: missing keyword: age

# twitter_user = {name: "Sophie", user_name: "sm_debenedetto", age: 26, location: "NY, NY", bio: "I'm a programmer living in NY!"}
# User.new(twitter_user) #=> ArgumentError: unknown keyword: bio

# in both instances our class breaks - we need a way to abstract away our User class' dependency on specific attributes.

# SOLUTION - metaprogramming and massassignment - improved User class
# initialize will take any number of arguments and assign them to the user instance.
# only those for which we've defined attr_accessors can we 'get/set'
# nil is returned for any getter where the value has not been set
class TwitterUser
  attr_accessor :name, :user_name, :age, :location, :bio

  # initialize takes an unspecified number of arguments as an attributes hash, which it then iterates over.
  # the name of the key becomes the name of the setter, which #send calls with the key's value as the value
  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
  end
end
