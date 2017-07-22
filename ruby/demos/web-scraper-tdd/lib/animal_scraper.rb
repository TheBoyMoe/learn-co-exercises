class AnimalScraper

  def self.wikipedia_scraper(url)
    doc = Nokogiri::HTML(open(url))

    animal = {}
    animal[:name] = doc.search("h1#firstHeading").text
    animal[:kingdom] = doc.search(".infobox a[href='/wiki/Animal']").text
    animal[:phylum] =	doc.search(".infobox a[title=Chordate]").text
    animal[:klass] =	doc.search(".infobox a[title=Mammal]").text
    animal[:order] =	doc.search(".infobox a[title^=Even-toed]").text
    animal[:family] =	doc.search(".infobox a[title=Hippopotamidae]").text
    animal[:genus] =	doc.search(".infobox a[title^=Hippopotamus]").text
    animal[:species] = doc.search("span.species").text
    animal
  end
end
