# dummy data
names = ['Tim', 'Tom', 'Simon', 'Jack', 'John']
nums = [1,2,3,4,5,6,7,8]
even = [2,4,6,8]
odd = [1,3,5,7]

#### implementation of #all #####

def my_all?(collection)
    if block_given?
         i = 0
    all_true = true
    while i < collection.length
        all_true = yield(collection[i])
        break if all_true == false
        i += 1
    end
    all_true
    else
        'No block given!'
    end
end

#test ##
result = my_all?(even) do |num|
    num % 2 == 0
end
puts result

puts "all pass: #{result}" #=> 'No block given!
my_all?(nums)

#### implementation of #none? #####
def my_none?(collection)
    if block_given?
        i =  0
        all_false = false
        while i < collection.length
            all_false = yield(collection[i])
            break if all_false == true
            i += 1
        end
        !all_false
    else
        'No block given'
    end
end

# test 
result = my_none?(odd) do |val|
    val % 2 == 0
end

puts "all fail: #{result}"


#### implementation of #any? ####

def my_any?(collection)
    if block_given?
        i =  0
        all_false = false
        while i < collection.length
            all_false = yield(collection[i])
            break if all_false == true
            i += 1
        end
        all_false
    else
        'No block given'
    end
end

result = my_any?(odd) do |val|
    val % 2 == 0
end

puts "any even? #{result}"