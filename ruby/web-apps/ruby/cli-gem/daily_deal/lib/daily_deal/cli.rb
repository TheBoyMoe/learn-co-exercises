# Cli controller, responsible for user interaction and business logic (the 'C' in MVC)
class DailyDeal::CLI

  def call
    self.list_deals
    self.menu
    self.goodbye
  end

  def list_deals
    # use gsub to strip out the leading spaces
    puts "Today's daily deal:"
    puts <<-doc.gsub(/^\s*/, '')
      1. Apple Mac Book Pro, 17in screen - $1200 - a few remain!
      2. Dell Inspiron laptop 15in screen - $299 - one left - grab a bargin!
    doc
  end

  def menu
    input = ''
    while input != 'exit'
      puts "Enter the number of the deal you would like more info on"
      puts "Enter 'list' to see deals, or enter 'exit'"
      input = gets.strip.downcase
      case input
      when '1'
        puts 'Display more info on deal 1...'
      when '2'
        puts 'Display more info on deal 2...'
      when 'list'
        self.list_deals
      when 'exit'
        # input = 'exit'
      else
        puts "Unknown selection"
      end
    end
  end

  def goodbye
    puts 'See you tomorrow for more deals!'
  end
end
