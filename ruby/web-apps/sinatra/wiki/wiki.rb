=begin

    Notes:
    - by default your app is configured to accept connections from the loacl machine.
    - use bind to set sinatra up to accept connections from any computer
    - by default sinatra looks in the /views dir for erb files
    - any html file can be rendered, just give it the erb ext
    - you can read files from the filesystem using the File class (sub class of IO)
    - the file contents are read into a string, if the file is not found a Errno::ENONET exception is thrown
    - if the call is within a method use the rescue statement to catch an deal with the exception.
    - otherwise place the call within a begin-end block, use rescue to catch the exception
    - using ERB tags, you embed Ruby code that displays changing, dynamic data into the static text. Each time the template is rendered, each piece of Ruby code is evaluated and those results are inserted into the template in place of the ERB tags, giving you text that changes each time the template is rendered.
    - ERB templates are loaded each time they're rendered, no need to restart the server everytime you change a template, just restart the server
    - regular embedding tags <% %>, the ruby code between the % is evaluated but is NOT placed into the output and so displayed, used for loops, conditionals (to include or exclude part of the template depending on the condition),etc 
    - output embedding tags <%= %>, ruby code is evaluated, the result is embedded into the output in the place of the tag
    - routes share the context with the erb template, thus instance variables defined in a route are accessible from the template

    References:
    [1] https://github.com/sinatra
    [2] http://www.sinatrarb.com/
    [3] https://developer.chrome.com/devtools
    [4] http://phrogz.net/programmingruby/tut_exceptions.html (exceptions in ruby)
    [5] http://ruby-doc.org/core-2.3.3/IO.html#method-i-print


=end

require 'sinatra'
require 'uri'

set :bind, '0.0.0.0'

# open the contents of a text file as a string
def page_content(title)
    File.read("pages/#{title}.txt")
rescue Errno::ENOENT
    # return nil
    return "No content found"
end

=begin
    Call File.open with the name of a file you want to save text to. The 2nd arg is the mode to open the file in, write in this case. 
    If you provide a block to File.open, it will pass the open file object to the block, and automatically close the file when the block is done.
    Whatever string you pass to print will be written to the file
=end
def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

# the first route to match the http verb and the request path will be run
get('/') do 
    erb :welcome
end

get('/new') do
    erb :new
end

# will accept any string the user appends to the url
# in sinatra every route receives the params obj automatically
get('/:title') do
    @title = params[:title]
    @content = page_content(@title)
    erb :show
end

# form data submitted via POST method is accessible via the params hash, review using params.inspect
post('/create') do
    # save the submitted data to text file
    save_content(params['title'], params['content'])
    # display the files contents using redirect - causes browser to make a GET request for the specified path
    # invalid charaters, e.g spaces, are encoded using the uri library
    redirect URI.escape("/#{params['title']}")
end
