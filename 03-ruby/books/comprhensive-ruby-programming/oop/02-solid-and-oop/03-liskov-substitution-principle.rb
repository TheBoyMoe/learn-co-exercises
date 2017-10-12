require 'date'
require 'ostruct'

class User
  attr_accessor :settings, :email

  def initialize(email:)
    @email = email
  end
end

class AdminUser < User
end

user = User.new(email: "user@test.com")
user.settings = {
  level: "Low Security",
  status: "Live",
  signed_in: Date.today
}

admin = AdminUser.new(email: "admin@test.com")
admin.settings = ["Editor", "VIP", Date.today]

puts user.settings
puts admin.settings

@user_database = [user, admin]

# breaks when trying to iterate over the AdminUser settings
def signed_in_today?
  @user_database.each do |person|
    if person.settings[:signed_in] == Date.today
      puts "#{person.email} signed in today"
    end
  end
end

=begin
  One way to solve this is to smply use a hash object for settings for the parent class and every child class

  Another way is to design the class to only have one option, thus the admin class can replace any instance of the child class
=end
class User
  attr_accessor :settings, :email

  def initialize(email:)
    @email = email
  end

    def set_settings(level:, status:, signed_in:)
     @settings = OpenStruct.new(
                                level: level,
                                status: status,
                                signed_in:  signed_in)
    end

    def get_settings
      @settings
    end

end

class AdminUser < User
end

user = User.new(email: "user@test.com")
user.settings = {level: "Low Security", status: "Live", signed_in: Date.today}

admin = AdminUser.new(email: "admin@test.com")
admin.settings = {level: "Editor", status: "VIP", signed_in: Date.today}

@user_database = [user, admin]

def signed_in_today?
  @user_database.each do |user|
    if user.settings[:signed_in] == Date.today
      puts "#{user.email} signed in today"
    end
  end
end
