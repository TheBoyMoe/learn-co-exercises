class ApiConnector
  attr_accessor :title, :description, :url

  # optional arguments, order matters
  # def initialize(title = nil, description = nil, url = nil)
  #   @title = title
  #   @description = description
  #   @url = url
  # end

  # named arguments with defaults, order does not matter
  # you MUST provide the argument where a default is not provided
  def initialize(title: nil, description: nil, url: nil)
    @title = title
    @description = description
    @url = url
  end

  def api_details
    puts self.title || 'unknown'
    puts self.description || "unknown"
    puts self.url || 'unknown'
  end

  def connector
    puts "Connecting to #{self.url}..."
  end
end
