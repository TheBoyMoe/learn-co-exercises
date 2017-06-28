=begin

    Notes:
    - by default your app is configured to accept connections from the loacl machine.
    - use bind to set sinatra up to accept connections from any computer

    References:
    [1] https://github.com/sinatra
    [2] http://www.sinatrarb.com/
    [3] https://developer.chrome.com/devtools
=end

require 'sinatra'

set :bind, '0.0.0.0'

# the first route to match the http verb and the request path will be run
get('/') {'Hello world!'}

get('/apple'){ '<h1>Here\'s a juicy apple!</h1>' }

get('/banana') { '<h1>You just won a banana!</h1>' }

get('/carrot') { '<h1>All that\'s left is this carrot</h1>' }