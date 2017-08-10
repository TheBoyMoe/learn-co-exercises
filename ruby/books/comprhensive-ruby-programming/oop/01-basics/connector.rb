class Connector
  attr_accessor :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end

  def api_logger
    "Name: #{self.name || 'unknown'}, description: #{self.description || 'unknown'}"
  end

end


class CallConnector < Connector
  attr_reader :phone_number

  def initialize(name, description, number)
    super(name, description)
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
