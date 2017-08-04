class RubyNews::RubyweeklyScraper
  attr_accessor :newsletter
  attr_reader :doc

  def initialize(issue_number)
    @newsletter = RubyNews::NewsLetter.new
    @newsletter.issue_number = issue_number
    @doc = Nokogiri::HTML(open("http://rubyweekly.com/issues/#{issue_number}"))
  end

  def scrape
    scrape_details
    scrape_articles
    @newsletter #=> should be an instance with a bunch of articles
  end

  def scrape_details
    # populate @newsletter with data from the newsletter site
    @newsletter.issue_date = @doc.search('table.gowide.lonmo').text.strip.gsub("Issue #{@issue_number}")
  end

  def scrape_articles
    # scrape the data, instantiate the articles an add to the newsletter, skip the first two tables (title and issue number)
    @doc.search("td[align='left'] table.gowide")[2..-1].each do |article_table|
      a = RubyNews::Article.new
      a.author = article_table.search('div:first').text.strip
      a.title = article_table.search('a:first').text.strip
      a.url = article_table.search('a:first').attr('href').text.strip
      a.description = article_table.search('div:last').text.strip
      @newsletter.add_article(a)
    end
  end

end
