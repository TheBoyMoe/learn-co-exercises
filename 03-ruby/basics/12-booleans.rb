=begin
    References
    [1] http://ruby-doc.org/core-2.1.5/TrueClass.html
    [2] http://ruby-doc.org/core-2.1.5/FalseClass.html
    [3] http://ruby-doc.org/core-2.1.5/NilClass.html
    

    - true and false classes in ruby are examples of singletons, only one instance of each can exist in the app at any moment in time.
    - you cannot instantiate true and false like other classes with the .new method, e.g TrueClass.new => NoMethodError
    - false is an instance of FalseClass, true of TrueClass
    - ruby also provides the nil value, an instance of the NilClass, it is also a singleton, and is the absence of a value
=end

puts true               # => true
puts true.class         # => TrueClass
puts true.inspect       # => "true"
puts true.to_s          # => "true"

puts false              # => false
puts false.class        # => FalseClass
puts false.inspect      # => "false"
puts false.to_s         # => "false"

puts nil.class          # => NilClass
puts nil.to_i           # => 0
puts nil.to_a           # => []
puts nil.to_h           # => {}
puts nil.nil?           # => true
puts nil.inspect        # => "nil"
puts !nil               # => true


## Conditional Assignment

new_name = "John"
new_name ||= "Andrew"
puts new_name #=> "John"

# OR

new_name = new_name || "Andrew"
puts new_name #=> "John"
