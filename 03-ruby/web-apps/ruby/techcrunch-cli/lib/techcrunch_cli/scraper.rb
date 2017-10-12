class TechcrunchCli::Scraper

  def initialize(url = nil)
    @url = url
  end

  def scrape_article
    # scrape the article content
    @doc = Nokogiri::HTML(open(@url))
    @doc.search('div.article-entry').text
  end

  def scrape_articles
    # scrape the index page, for each article, fetch it's data and instantiate a story based on that data
    @doc = Nokogiri::HTML(open('https://techcrunch.com'))
    @doc.search('li.river-block').each do |article_li|
      story = TechcrunchCli::Story.new
      a_tag = article_li.search('h2 a')
      if a_tag
        story.url = a_tag.attr('href').text
        story.title = article_li.search('h2.post-title').text
        story.author = article_li.search('div.byline').text
        story.summary = article_li.search('p.excerpt').text
        story.save
      end
    end
  end
end
