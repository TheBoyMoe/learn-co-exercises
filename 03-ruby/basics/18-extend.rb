
# the tracking module creats an instance of something, pushes it on to an instances array, and then can find it in said array.
module Tracking
  def create(name)
    object = new(name)
    instances.push(object)
    return object
  end

  def instances
    @instances ||= []
  end

  def find(name)
    instances.find do |instance|
      instance.name == name
    end
  end
end

# when we use the extend keyword, these methods will apply at the class level and not the instance level
class Customer
  extend Tracking

  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def to_s
    "[#{@name}]"
  end
end

# tracking module methods now run at the class level and return instances of the class we just created
puts "Customer.instances: %s" % Customer.instances.inspect #=> Customer.instances: []

puts "Customer.create: %s" % Customer.create("Jason") #=> Customer.create: [Jason]

puts "Customer.create: %s" % Customer.create("Kenneth") #=> Customer.create: [Kenneth]

puts "Customer.instances: %s" % Customer.instances.inspect #=> Customer.instances: [#<Customer:0x007f2b23eabc08 @name="Jason">, #<Customer:0x007f2b23eabaf0 @name="Kenneth">]

puts "Customer.find('Jason'): %s" % Customer.find("Jason") #=> Customer.find('Jason'): [Jason]

puts "Customer.find('Mike'): %s" % Customer.find("Mike") #=> Customer.find('Mike'):     

