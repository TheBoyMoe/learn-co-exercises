=begin 
    using blocks with built in ruby methods

    References
    [1] http://ruby-doc.org/core-2.2.0/String.html
    [2] http://ruby-doc.org/core-2.2.0/Integer.html
    [3] http://ruby-doc.org/core-2.2.0/Array.html
    [4] http://ruby-doc.org/core-2.2.0/Hash.html
=end

# strings and numbers
string = 'hello'
string.each_char do |char|
    print "#{char}-"
end

puts "\n"

# each_char returns a string
str = string.each_char {|char| print "#{char}-"}.upcase
puts "\n"
puts str

10.downto(0) {|num| print "#{num}... "}
puts "\n"


# arrays
array = [0,1,2,3,4,5,6,7,8,9,10]
array.reverse.each {|num| print "#{num}... "}
puts "\n"

array.select {|num| print "#{num} " if num % 2 == 0}
puts "\n"

array.delete_if {|num| num % 2 == 0}
print array
puts "\n"

puts array.count {|num| num % 2 != 0}
puts "\n"

# hashes hash.each, each_key and each_value take blocks
hash = {name: 'John Smith', address: "1 the street, the town, the country", phone: '11111111'}
puts hash.inspect
hash.each {|prop| puts "#{prop}"}
hash.each_key {|key| puts "key: #{key}"}
hash.each_value {|value| puts "value: #{value}"}

# other methods include reject, select and keep_if
hash.keep_if{ |key, val| key == :name }
puts hash.inspect #=> {:name=>"John Smith"} # changes the original hash

val = hash.reject {|key, value| key == :name}
puts val #=> {}
puts hash.inspect #=> {:name=>"John Smith"}

result  = hash.select { |key, val| key == :name}
puts "Result #{result}" #=> {:name=>"John Smith"}


=begin
    One way that blocks are really useful is performing functionality or running code before and after the block is executed. This turns out to be really great for writing something like a benchmarker. In this video, we'll practice writing a very simple benchmarking class.
=end

# the benchmarker will measure the length of tim it takes to execute the code in the block
class BenchMarker
    def run(&block)
        start_time = Time.now
        block.call
        end_time = Time.now
        elapsed = end_time - start_time
        puts "Elapsed time #{elapsed}"
    end
end

benchmark = BenchMarker.new
benchmark.run do
    # 1000000.times { 100 * 100}
    5.times do
        print "."
        sleep(rand(0.1..1.0))
    end
end

 
# mimic array using blocks
class MyArray
    attr_reader :array
    def initialize
        @array = []
    end
    
    def push(item)
        array.push(item)
    end

    # impl each method using blocks
    def each(&block)
        i = 0
        while i < array.length
            block.call(array[i])
            i += 1
        end
        array
    end

end

my_array = MyArray.new
my_array.push(1)
my_array.push(2)
my_array.push(3)
my_array.push(4)
my_array.push(5)
my_array.each do |value|
    value *= 2
    puts "value: #{value}"
end

