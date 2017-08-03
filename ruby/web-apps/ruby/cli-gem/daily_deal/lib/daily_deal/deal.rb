class DailyDeal::Deal
  attr_accessor :name, :price, :availability, :url

  def self.today
    # should return an array of instances of Deal
    puts <<-doc.gsub(/^\s*/, '')
      1. Three pairs of Huggie Earings - $18 - a few remain!
      2. iJoy Logo - wireless headphones - $17 - one left - grab a bargin!
    doc

    deal_1 = self.new
    deal_1.name = 'Three pairs of Huggie Earings'
    deal_1.price = '$18'
    deal_1.availability = true
    deal_1.url = 'https://meh.com/'

    deal_2 = self.new
    deal_2.name = 'iJoy Logo - wireless headphones'
    deal_2.price = '$17'
    deal_2.availability = true
    deal_2.url = 'https://electronics.woot.com/offers/ijoy-logo-bt-neckband-headphones-2pk'

    [deal_1, deal_2]
  end
end
