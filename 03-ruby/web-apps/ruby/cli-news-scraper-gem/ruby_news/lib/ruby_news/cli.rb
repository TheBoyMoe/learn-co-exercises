class RubyNews::CLI

  def initialize
    puts 'Welcome to Ruby Weekly Newsletter!'
    s = RubyNews::RubyweeklyScraper.new(360)
    @newsletter = s.scrape # fetch articles, returning a newletter instance
  end

  def call
    input = ''
    while input != 'exit'
      puts "Type 'list' to list articles, 'exit' to exit"
      puts "What would you like to do?"
      input = gets.strip
      case input
      when 'list'
        list_articles
      when 'exit'
        puts 'Goodbye'
        break
      else
        # open the default application for the file
        system("open #{@newsletter.articles[input.to_i - 1].url}")
      end
    end
  end

  def list_articles
    @newsletter.articles.each.with_index(1) do |article, i|
      puts "#{i}. #{article.title}"
    end
  end
end
