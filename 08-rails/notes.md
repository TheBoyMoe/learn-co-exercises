## Sinatra vs Rails

In rails:

  * map all routes to controller actions, place them in routes.rb  file
    - controllers become plain ruby class
    - actions a simply methods
    - in Sinatra the the route/action is all in one

  * rendering of views can be either implicit or explicit
    - in Sinatra it's all explicit, you have to define the file to be rendered, e.g `erb :'/posts/show'`
    - in Rails, it will look for views matching the action name, e.g. place show.html.erb in /views it it will be automatically rendered when the #show action in the Products controller is called - you don't even need any logic in the `def show; end` action (or define the action if it's empty, e.g. for static routes)

  * comes with a lot of 'instrumentation' - in Sinatra you need to create all your files, mount your controllers all manually. Rails comes with a series of helpers, `ActionView` which will generate html for you - Sinatra you write it yourself.  

  * provides the 'Asset Pipeline' - used to bundle/process css, js and and images for your finished app. 
