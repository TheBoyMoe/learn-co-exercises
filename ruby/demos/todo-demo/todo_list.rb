require "./todo_item"

class TodoList
    attr_reader :name, :todo_items

    def initialize(name)
        @name = name
        @todo_items = []
    end

    def add_item(name)
        todo_items.push(TodoItem.new(name))
    end

    def remove_item(name)
        index = find_index(name)
        if index
            todo_items.delete_at(index)
            return true
        else
            return false    
        end
    end

    def mark_complete(name)
        index = find_index(name)
        if index
            todo_items[index].mark_complete!
            return true
        else
            return false
        end
    end

    def to_s
        puts "#{name}:"
        todo_items.each do |item|
            item.name
        end
    end

    # helper methods
    def find_index(name)
        index = nil;
        # found = false
        # todo_items.each do |item|
        #     if item.name == name
        #         found = true
        #     end
        #     (found)? break : index += 1    
        # end
        # (found)? index : nil
        
        todo_items.each_with_index do |item, i|
            if item.name == name
                index = i
            end    
        end
        index
    end

    def contains?(name)
        find_index(name) 
    end

    def print_list(kind = 'all')
        puts "#{name} List - #{kind} items"
        puts "-" * 30
        todo_items.each do |todo_item|
        case kind
            when 'all'
                puts todo_item
            when 'complete'
                puts todo_item if todo_item.complete?
            when 'incomplete'
                puts todo_item unless todo_item.complete?
            end            
        end
        puts "\n"
    end

end

todo_list = TodoList.new("Groceries")
todo_list.add_item('milk')
todo_list.add_item('bread')
todo_list.add_item('cheese')
todo_list.add_item('eggs')

puts todo_list.print_list

todo_list.remove_item('cheese')
todo_list.mark_complete('bread')
todo_list.mark_complete('eggs')

puts todo_list.print_list
# puts todo_list.print_list('complete')
# puts todo_list.print_list('incomplete')