=begin
  Reference:
  [1] http://ruby.bastardsbook.com/chapters/html-parsing/

  * The css method returns an array of Nokogiri::XML::Element objects
  * You can use the #css method to target elements, class, ids and attributes
    or a 'mixture' - chaining them as you would do in css or jQuery

  TEST PAGE

  <html>
     <head><title>My webpage</title></head>
     <body>
     <h1>Hello Webpage!</h1>
     <div id="references">
        <p><a href="http://www.google.com">Click here</a> to go to the search engine Google</p>
        <p>Or you can <a href="http://www.bing.com">click here to go</a> to Microsoft Bing.</p>
        <p>Don't want to learn Ruby? Then give <a href="http://learnpythonthehardway.org/">Zed Shaw's Learn Python the Hard Way</a> a try</p>
     </div>

     <div id="funstuff">
        <p>Here are some entertaining links:</p>
        <ul>
           <li><a href="http://youtube.com">YouTube</a></li>
           <li><a data-category="news" href="http://reddit.com">Reddit</a></li>
           <li><a href="http://kathack.com/">Kathack</a></li>
           <li><a data-category="news" href="http://www.nytimes.com">New York Times</a></li>
        </ul>
     </div>

     <p>Thank you for reading my webpage!</p>

     </body>
  </html>

=end
require 'open-uri'
require 'nokogiri'

html = open('http://ruby.bastardsbook.com/files/hello-webpage.html')
doc = Nokogiri::HTML(html)
puts doc.css('title') #=> <title>My webpage</title>
puts doc.css('title')[0].name #=> title (element/tag name)
puts doc.css('title')[0].text #=> 'My webpage' (element/tag text)
puts doc.css('li') #=> array of li elements
puts doc.css('li').inspect #=> returns an array of Nokogiri::XML::Element objects
puts
puts doc.css('li')[0].text #=> 'YouTube' (text of the first li element in the array)
puts doc.css('div#funstuff a')[1]['href'] #=> 'http://reddit.com' (get elements attributes)

##### news links - iterate through all the page links, selecting those with an attribute of 'data-category = news'
news_links = doc.css('a').select {|link| link['data-category'] == 'news'}
puts news_links
#=> <a data-category="news" href="http://reddit.com">Reddit</a>
#=> <a data-category="news" href="http://www.nytimes.com">New York Times</a>

#iterate through those links and print the url
news_links.each {|a| puts a['href']}
#=> http://reddit.com
#=> http://www.nytimes.com

## a more succint solution is to use attribute selectors in the initial #css method call
news_links = doc.css('a[data-category=news]')
news_links.each {|a| puts a['href']}
#=> http://reddit.com
#=> http://www.nytimes.com

doc.css('a[data-category=news]').each {|a| puts a['href']}
#=> http://reddit.com
#=> http://www.nytimes.com


### You can call #css more than once - return any <strong> elms found in <a> with the 'data-category=news', which are found in <p> elements
doc.css('p').css("a[data-category=news]").css("strong")
# or
doc.css('p a[data-category=news] strong')
