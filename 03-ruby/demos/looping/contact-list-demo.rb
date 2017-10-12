# cli app which prom[ts user to create a contact list and populate with their friends

contact_list = []

def ask(question, kind = 'string')
    print question + ' '
    answer = gets.chomp
    answer = answer.to_i if kind == 'number'
end

def add_contact 
    contact = {"name" => "", "phone_numbers" => []}
    contact["name"] = ask("What is the contact's name?")
    answer = ""
    while answer != "n"
        answer = ask("Do you want to add a phone number?")
        if answer == "y"
            phone = ask("Enter a phone number: ")
            contact["phone_numbers"].push(phone)
        end
    end
    contact
end

answer = ""
while answer != "n"
    contact_list.push(add_contact)
    answer = ask("Add another? (y/n)")
end

# print the results
puts "------------------"
contact_list.each do |contact|
    puts "Name: #{contact['name']}"
    if contact["phone_numbers"].size > 0
        contact["phone_numbers"].each do |phone_number|
            puts "Phone: #{phone_number}"
        end    
    end
    puts "------------------"
end