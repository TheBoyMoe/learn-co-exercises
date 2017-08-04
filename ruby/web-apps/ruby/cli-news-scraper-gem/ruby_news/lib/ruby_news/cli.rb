class RubyNews::CLI

  def initialize
    puts 'Welcome to Ruby Weekly Newsletter!'
    s = RubyNews::RubyweeklyScraper.new(360)
    @newsletter = s.scrape # fetch articles, returning a newletter instance
  end

  def call
    @newsletter.articles.each.with_index(1) do |article, i|
      puts "#{i}. #{article.title}"
    end
  end
end
