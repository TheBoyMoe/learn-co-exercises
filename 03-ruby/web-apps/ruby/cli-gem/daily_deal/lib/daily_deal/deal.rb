class DailyDeal::Deal
  attr_accessor :name, :price, :availability, :url, :description

  def self.today
    # should return an array of instances of Deal
    # puts <<-doc.gsub(/^\s*/, '')
    #   1. Three pairs of Huggie Earings - $18 - a few remain!
    #   2. iJoy Logo - wireless headphones - $17 - one left - grab a bargin!
    # doc

    # scrape woot and meh
    self.scrape_deals

    # dummy data
    # deal_1 = self.new
    # deal_1.name = 'Three pairs of Huggie Earings'
    # deal_1.price = '$18'
    # deal_1.availability = true
    # deal_1.url = 'https://meh.com/'
    #
    # deal_2 = self.new
    # deal_2.name = 'iJoy Logo - wireless headphones'
    # deal_2.price = '$17'
    # deal_2.availability = true
    # deal_2.url = 'https://electronics.woot.com/offers/ijoy-logo-bt-neckband-headphones-2pk'

    # [deal_1, deal_2]
  end

  def self.scrape_deals
    deals = []
    deals << self.scrape_woot
    deals << self.scrape_meh
    deals
  end

  # causes undefined local variable or method error
  # def self.scrape_woot
  #   doc = Nokogiri::HTML(open("https://www.woot.com/category/computers?ref=el_gh_cp_4"))
  #
  #   deal = self.new
  #   deal.name = doc.css('#daily-deal-section .title-section .main-title').text
  #   price = doc.css('#daily-deal-section .title-section .price').text
  #   price = price.slice(1, price.length - 1)
  #   deal.price = "$#{price.to_i/100}.#{price.slice(price.length - 2, price.length - 1)}"
  #   deal.url = doc.css('#daily-deal-section a.tc-shop-now').attr('href').text
  #   deal.description = doc.css('#daily-deal-section .inner-excerpt h2 + p').text
  #   deal.availability = true
  #
  #   deal
  # end

  def self.scrape_woot
    doc = Nokogiri::HTML(open("https://woot.com"))

    deal = self.new
    deal.name = doc.search("h2.main-title").text.strip
    deal.price = doc.search("#todays-deal span.price").text.strip
    deal.url = doc.search("a.wantone").first.attr("href").strip
    deal.availability = true

    deal
  end

  def self.scrape_meh
    doc = Nokogiri::HTML(open("https://meh.com"))

    deal = self.new
    deal.name = doc.search("section.features h2").text.strip
    deal.price = doc.search("button.buy-button").text.gsub("Buy it.", "").strip
    deal.url = "https://meh.com"
    deal.availability = true

    deal
  end

end
