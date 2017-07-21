=begin
  References:
  [1] http://www.nokogiri.org/tutorials/parsing_an_html_xml_document.html
  [2] http://ruby.bastardsbook.com/chapters/html-parsing/
=end

require 'nokogiri'
require 'open-uri'

# returns the raw html as a string
# html = open("https://flatironschool.com/")

# parse the html as a NodeSet which can be iterated over
# doc = Nokogiri::HTML(html)

# Nokogiri allows you to use CSS selectors in order to retrieve specific pieces of information out of an HTML document.
# puts doc.css('.site-header__hero__subhead')

#=> <div class="site-header__hero__subhead">You can learn to code anywhere; students come to Flatiron School to change their lives. Join our driven community of career-changers and master the skills you need to become a software engineer.</div>



# retrieve a collection of elements, and iterate over them
html = open("https://flatironschool.com/about-flatiron-school/")
doc = Nokogiri::HTML(html)
elements = doc.css(".carousel__list")

# test
# puts instructors.inspect
array = elements.collect do |element|
  "Founders bio: #{element.css("h2.heading").text}\n#{element.css(".text-block").text}"
end
puts array[0]
