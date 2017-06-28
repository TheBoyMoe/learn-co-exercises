### Ruby Gems ###

# if you know the gem's name - ruby gems will download and install the package
gem install [gem_name]

# if you download a gem package
gem install [package_name.gem]

# eoither way the gem and any dependencies will be installed
# to view a list of all installed gems
gem list

# to use a gem in a particular app, use the require statement
# ruby will import the gem from the local repo
require 'gem_name'

# to get help
gem help
gem help commands #=> list all gem commands
gem help examples #=> show some example usagess
gem hemp [command_name] #=> help with that specific command
gem server #=> launches a webserver which displays info about every installed gem at http://localhost:8808

gem build [gemspec_file] #=> create a gem from a ruby gemspec
gem check [gem_name] #=> Check and repair a gem repository for added or missing files
gem cleanup [gem_name] #=> removes old versions of gems not req'd to meet a dependency, removes all if name not specified
gem install [gem_name]
gem install [gem_name] -v [ver_no] #=> to install a specific version
gem uninstall [gem_name]
gem uninstall [gem_name] -v [ver_no] #=> to uninstall a particular version
gem update [gem_name] #=>  update your gem(s) to the latest version, name optional. Use cleanup to remove old versions
gem pristine [gem_name]/--all #=> compares installed gem(s) with the contents of its cache and restores any files that don't match
gem outdated [gem_name]/--all #=> display gems that need updating
gem dependency [REGEXP] #=> show dependencies for gems whose names start with REGEXP
gem environment #=> displays ruby gem environment, e.g version, file paths, configuration
gem list #=> lists installed gems and versions
gem search [REGEXP] #=> displays remote gems whose name matches the given regexp
gen content [gem_name] #=> view gem files