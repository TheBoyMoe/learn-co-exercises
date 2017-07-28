
The following command tells bash that the following commands are ruby

````markdown
!/usr/bin/env ruby
````

Loading files in ruby:
1. require              
  - look for files/gems in the $LOAD_PATH, does not work with relative paths because your current directory is not in your $LOAD_PATH.
  - can be inconsistent since it depends upon what is in the users $LOAD_PATH, use to load gems only
2. require_relative     
  - relative to the current file, consistent, not dependent on the $LOAD_PATH
  - can only load one file at a time, use the require_all gem to load all the files in a folder
  - you can leave off the file extension (same as require)
3. load
  - load files in an irb session, files are relative to the folder your in when executing the command  
  - you can also use require_relative, once the file is loaded if you try and read the file again with another require_relative command the interpreter will not read it (unlike load) and will return false
