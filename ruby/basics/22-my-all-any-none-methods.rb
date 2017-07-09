# dummy data
names = ['Tim', 'Tom', 'Simon', 'Jack', 'John']
no_ts = ['Simon', 'Jack', 'John', 'Mick']
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

#### implementation of select? (filter) ###

def my_select(collection)
    if block_given?
        i =  0
        matches = []
        while i < collection.length
            result = yield(collection[i])
            if result
                matches << collection[i]
            end
            i += 1
        end
        matches
    else
        'No block given'
    end
end

# test 
result = my_select(names) do |name|
    name.start_with?('T')
end

puts "start with t: #{result.inspect}"

result = my_select(no_ts) do |name|
    name.start_with?('T')
end

puts "no ts: #{result.inspect}"


#### implementation of #reject - return all values which fail condition #####

def my_reject(collection)
    if block_given?
        i =  0
        rejects = []
        while i < collection.length
            result = yield(collection[i])
            if !result
                rejects << collection[i]
            end
            i += 1
        end
        rejects
    else
        'No block given'
    end
end

# test
result = my_reject(nums) do |num|
    num % 2 == 0
end

puts nums.inspect
puts "All odd numbers: #{result.inspect}"


#### implementation of #detect - return the first matching element ####

def my_detect(collection)
    if block_given?
        i =  0
        match = []
        while i < collection.length
            result = yield(collection[i])
            if result
                match << collection[i]
            end
            i += 1
        end
        match.first
    else
        'No block given'
    end
end

# test
result = my_detect(names) do |name|
    name.start_with?('J')
end

puts names.inspect
puts "First match stating with 'J': #{result}"

result = my_detect(no_ts) do |name|
    name.start_with?('T')
end

puts no_ts.inspect
puts "First match starting with 'T': #{result}"