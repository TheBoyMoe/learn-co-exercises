class TechcrunchCli::Story
  attr_accessor :title, :author, :summary, :url, :content
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def content
    @content ||= TechcrunchCli::Scraper.new(self.url).scrape_article
  end

  def open_in_browser
    system("gnome-open '#{self.url}'")
  end

end
