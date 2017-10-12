class ApiConnector
  attr_accessor :name, :description

  # optional arguments, order matters
  # def initialize(title = nil, description = nil, url = nil)
  #   @title = title
  #   @description = description
  #   @url = url
  # end

  # named arguments with defaults, order does not matter
  # you MUST provide the argument where a default is not provided
  def initialize(name: nil, description: nil)
    @name = name
    @description = description
    # self.log_connection #=> causes NoMethodError when instantiating a child class
  end

  def api_logger
    "Name: #{self.name || 'unknown'}, description: #{self.description || 'unknown'}"
  end

  # private methods are accessible only from within the class, not accessible from child classes (NoMethodError)
  private
    def log_connection
      "Made a connection to: #{self.name}, about: #{self.description}"
    end
end


class PhoneConnector < ApiConnector
  attr_reader :phone_number

  # when using named arguments, use the **args pattern to pass arguments up to the parent initializer, supports the use of default values.
  def initialize(number:, **args)
    super(**args)
    @phone_number = number
  end

  def place_call
    puts "Calling #{self.phone_number}..."
  end

  # example of polymorhism, override method in the parent class
  # use the super keyword to call the parent's version of #api_looger
  def api_logger
    puts "#{super}, calling #{self.phone_number}..."
  end

end
