#use of super keyword
class User
  attr_accessor :name
  attr_reader :logged_in

  def initialize(name)
    @name = name
  end

  def log_in
    @logged_in = true
  end

  def log_out
    @logged_in = false
  end
end


class Student < User
  attr_reader :in_class

  def log_in
    super
    @in_class = true
  end

  def log_out
    super
    @in_class = false
  end
end


class Teacher < User

end
