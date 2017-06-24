# prompt user for list name, create and return said list as a hash
def create_list
    print 'What is the list name? '
    name = gets.chomp
    hash = {'name' => name, 'items' => Array.new}
end

# prompt user for item name and create item hash
def add_list_item
    print 'What is the item called? '
    name = gets.chomp
    print 'How many? '
    quantity = gets.chomp.to_i

    hash = {'name' => name, 'quantity' => quantity}
end

def print_list(list)
    puts "List: #{list['name']}"
    print_separator
    list['items'].each do |item|
        puts "\tItem:\t#{item['name']}\t\tQuantity:\t#{item['quantity']}"
    end
    print_separator
    puts
end

def print_separator(char = '-')
    puts char * 60
end

list = create_list
add_items = true

while add_items
    print "Add an item to the list?(y/n) "
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'yes'
        list['items'].push(add_list_item)
    else
        add_items = false
    end
end

print_list(list)