## How to build a CLI gem

1. plan you gem, imagine your interface
    - cli for daily deals on woot.com and meh.com
    - e.g. display the daily deal from each site, git the user the option to select either to view more information
2. start with the project structure
    - use 'bundle gem [gem_name]' command
3. start with the entry point file - './bin/daily/deal'
4. which loads the cli interface - loads the environment and launches the app
5. stub out the cli interface
6. define the model
    - a deal has a name
    - a deal has a description
    - a deal has a price
    - a deal has a URL
    - a deal has an availability



## References
1. [Multiline strings - here docs](http://blog.jayfields.com/2006/12/ruby-multiline-strings-here-doc-or.html)
