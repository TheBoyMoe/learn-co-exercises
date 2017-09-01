require 'sinatra'

require_relative 'config/environment'

# load the 'about' controller
use AboutController

# run the application controller
# only one controller (application) is loaded via run
run ApplicationController
