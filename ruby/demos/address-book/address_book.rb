require "./contact"

class AddressBook
    attr_reader :contacts

    def initialize
        @contacts = []
    end

    def print_contact_list
        puts "Contact List:"
        contacts.each do |contact|
            puts contact.to_s('last_first')
        end
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

jpjones = Contact.new
jpjones.first_name = "John"
jpjones.middle_name = "Paul"
jpjones.last_name = "Jones"
jpjones.add_phone_number("Home", "123-456-7896")
jpjones.add_phone_number("Work", "456-789-4565")
jpjones.add_address("Home", "123 Main St.", "", "Portland", "OR", "12345")
address_book.contacts.push(jpjones)

tjones = Contact.new
tjones.first_name = "Tom"
tjones.last_name = "Jones"
tjones.add_phone_number("Home", "123-456-7896")
tjones.add_phone_number("Work", "456-789-4565")
tjones.add_address("Home", "123 Main St.", "", "Portland", "OR", "12345")
address_book.contacts.push(tjones)

# address_book.print_contact_list
address_book.find_by_name('t')