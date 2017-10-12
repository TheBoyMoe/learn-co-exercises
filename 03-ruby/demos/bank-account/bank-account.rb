class BankAccount
    attr_reader :name

    def initialize(name)
        @name = name
        @transactions = []
        add_transaction("Openning balance", 0)
    end
    
    def add_transaction(description, amount)
        @transactions.push(description: description, amount: amount)
    end

    def credit(description, amount)
        add_transaction(description, amount)
    end

    def debit(description, amount)
        add_transaction(description, -amount)
    end

    def balance
        balance = 0
        @transactions.each do |transaction|
            balance += transaction[:amount]
        end
        balance
    end

    def print_register
        puts "#{@name}'s Bank Account"
        puts "-" * 40
        puts "Description".ljust(30) + "Amount".rjust(10)
        @transactions.each do |transaction|
            puts "#{transaction[:description].ljust(30)}#{sprintf("%0.2f", transaction[:amount]).rjust(10)}"
        end
        puts "-" * 40
        puts "Closing balance".ljust(30) + sprintf("%0.2f", balance).rjust(10)
        puts "-" * 40
    end

    def to_s
        "Name: #{@name}, Balance: $#{sprintf("%0.2f", balance)}"
    end
end

bank_account = BankAccount.new('John')
bank_account.credit("Paycheck", 1000)
bank_account.debit("Groceries", 40)
bank_account.debit("Mortgage", 140)
bank_account.debit("Hair cut", 20)
puts bank_account
bank_account.print_register