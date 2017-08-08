class TechcrunchCli::Story
  # We never instantiate instances of Stories.
  # Rather, we just call class methods on this all time.

  # Class Instance Variable
  attr_accessor :title, :author, :summary, :href, :content

  def self.scrape_content(url)
    @doc = Nokogiri::HTML(open(url))
    content = @doc.search("div.article-entry").text.strip
  end

  def self.scrape_urls
    @doc = Nokogiri::HTML(open('https://techcrunch.com/'))

    hrefs = [] # always the same
    @doc.search("ul#river1 h2.post-title a").each do |a|
      hrefs << a.attr("href") # different
    end
    hrefs # always the same
  end

  def self.scrape_titles
    @doc = Nokogiri::HTML(open('https://techcrunch.com/'))

    titles = [] # always the same
    @doc.search("ul#river1 h2.post-title").each do |h2|
      titles << h2.text # different
    end
    titles # always the same
  end

  def self.scrape_authors
    @doc = Nokogiri::HTML(open('https://techcrunch.com/'))
    authors = @doc.search("ul#river1 div.byline").text.split("by")
    authors
  end

  def self.scrape_summaries
    @doc = Nokogiri::HTML(open('https://techcrunch.com/'))
    summaries = @doc.search("ul#river1 p.excerpt").text
    summaries.split("Read More")
  end
end
