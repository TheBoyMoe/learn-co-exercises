class TechcrunchCli::Story
  attr_accessor :title, :author, :summary, :url, :content
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end
end
