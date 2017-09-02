require 'sinatra'

require_relative 'config/environment'

# ALL controllers need to be defined here - mounting a controller!

# load the controllers
# these are checked in order, top-down, until a controller is found that can handle the particular request.
use AboutController
use PostsController

# run the application controller
# only one controller (application) is loaded via run
run ApplicationController
