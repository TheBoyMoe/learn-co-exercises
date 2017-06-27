=begin
    YAML - a class found in the std ruby library, it will serialise our ruby objects into a text based format which can be written out to a file
    IO   - a class found in the std library, it is used to read/write to the file system
=end

require "./contact"
require 'yaml'

class AddressBook
    attr_reader :contacts

    def initialize
        @contacts = []
        open() # load any saved contacts
    end

    # if the file exists, replace the contacts with the contents of the yaml file
    def open
        if File.exist?("contacts.yml")
            @contacts = YAML.load_file("contacts.yml")
        end
    end

    # write the contact list out each time save is called
    def save
        File.open("contacts.yml", "w") do |file|
            file.write(contacts.to_yaml)
        end
    end

    def run
        loop do
            puts "-" * 20
            puts "Address Book:"
            puts '-' * 20
            puts "a: Add Contact"
            puts "p: Print Address Book"
            puts "s: Search"
            puts "e: Exit"
            puts "-" * 20
            print 'Enter your choice: '
            input = gets.chomp
            case input
            when 'a'
                add_contact
            when 'p'
                print_contact_list
            when 's'
                print "Search term: "
                search = gets.chomp
                find_by_name(search)
                find_by_phone_number(search)
                find_by_address(search)    
            when 'e'
                save() # save contacts prior to exiting 
                break
            end
        end
    end

    def add_contact
        contact = Contact.new
        print "First name: "
        contact.first_name = gets.chomp
        print "Middle name: "
        contact.middle_name = gets.chomp
        print "Last name: "
        contact.last_name = gets.chomp

        loop do
            puts "Add phone number or address? "
            puts "p: Add phone number"
            puts "a: Add address"
            puts "(Any other key to go back)"
            response = gets.chomp.downcase
            case response
            when 'p'
                phone = PhoneNumber.new
                print "Phone number kind (Home, Work, etc): "
                phone.kind = gets.chomp
                print "Number: "
                phone.number = gets.chomp
                contact.phone_numbers.push(phone)
            when 'a'
                address = Address.new
                print "Address Kind (Home, Work, etc): "
                address.kind = gets.chomp
                print "Address line 1: "
                address.street_1 = gets.chomp
                print "Address line 2: "
                address.street_2 = gets.chomp
                print "City: "
                address.city = gets.chomp
                print "State: "
                address.state = gets.chomp
                print "Postal Code: "
                address.postal_code = gets.chomp
                contact.addresses.push(address)
            else
                print "\n"
                break
            end
        end

        contacts.push(contact) 
    end

    def print_contact_list
        puts "-" * 20
        puts "Contact List:"
        puts "-" * 20
        if contacts.length >0 
            contacts.each do |contact|
                puts contact.to_s('last_first')
            end
        else
            puts "No contacts to display"
        end
        puts "\n"    
    end

    def find_by_name(name)
        results = []
        search = name.downcase
        contacts.each do |contact|
            # search the full name for the search term
            if contact.full_name.downcase.include?(search)
                results.push(contact)
            end
        end
        print_results("Name search results (#{search}):", results)
    end

    def find_by_phone_number(number)
        results = []
        # replace '-' with ''
        search = number.gsub("-", "")
        contacts.each do |contact|
            contact.phone_numbers.each do |phone_number|
                if phone_number.number.gsub("-", "").include?(search)
                    results.push(contact) unless results.include?(contact)
                end
            end
        end
        print_results("Phone search results (#{search}):", results)
    end

    def find_by_address(query)
        results = []
        search = query.downcase
        contacts.each do |contact|
            contact.addresses.each do |address|
                if address.to_s('long').downcase.include?(search)
                results.push(contact) unless results.include?(contact)
                end
            end
        end
        print_results("Address search results (#{search})", results)
    end

    def print_results(search, results)
        puts 
        results.each do |contact|
            puts contact.to_s('full_name')
            contact.print_phone_numbers
            contact.print_addresses
            puts "\n"
        end
    end

end

address_book = AddressBook.new

# display the address book menu
address_book.run 



# jpjones = Contact.new
# jpjones.first_name = "John"
# jpjones.middle_name = "Paul"
# jpjones.last_name = "Jones"
# jpjones.add_phone_number("Home", "123-456-7896")
# jpjones.add_phone_number("Work", "456-789-4565")
# jpjones.add_address("Home", "123 Main St.", "", "Portland", "OR", "12345")
# address_book.contacts.push(jpjones)

# tjones = Contact.new
# tjones.first_name = "Tom"
# tjones.last_name = "Jones"
# tjones.add_phone_number("Home", "123-456-7896")
# tjones.add_phone_number("Work", "456-789-4565")
# tjones.add_address("Home", "123 Main St.", "", "Portland", "OR", "12345")
# address_book.contacts.push(tjones)

# address_book.print_contact_list
# address_book.find_by_name('t')