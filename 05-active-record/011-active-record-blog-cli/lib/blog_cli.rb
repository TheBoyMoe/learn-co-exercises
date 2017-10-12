require_relative '../config/environment'

# prevent the program from running if there is a pending migration
ActiveRecord::Migration.check_pending!

module BlogCLI
end

require "blog_cli/version"
require "blog_cli/cli"
require "blog_cli/post"
require "blog_cli/author"
require "blog_cli/category"
