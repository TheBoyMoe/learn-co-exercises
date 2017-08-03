# Cli controller, responsible for user interaction and business logic (the 'C' in MVC)
class DailyDeal::CLI

  def call
    self.list_deals
    self.menu
    self.goodbye
  end

  def list_deals
    # use gsub to strip out the leading spaces
    puts '----------------------------------------------------'
    puts "Today's daily deal:"
    # define a Deal class with a class method 'today'
    @deals = DailyDeal::Deal.today
    @deals.each.with_index(1) do |deal, i| # start with index of 1
      puts "#{i}. #{deal.name} - #{deal.price} - #{deal.availability}"
    end
    puts '----------------------------------------------------'
  end

  def menu
    input = nil
    while input != 'exit'
      puts "Enter the number of the deal you would like more info on"
      puts "Enter 'list' to see deals, or enter 'exit'"
      input = gets.strip.downcase

      if input.to_i > 0
        deal = @deals[input.to_i - 1]
        puts '----------------------------------------------------'
        puts "#{deal.name} - #{deal.price} - #{deal.availability}"
        puts '----------------------------------------------------'
      elsif input == 'list'
        self.list_deals
      elsif input == 'exit'
      else
        puts "Unknown selection"
      end
    end
  end

  def goodbye
    puts 'See you tomorrow for more deals!'
  end
end
