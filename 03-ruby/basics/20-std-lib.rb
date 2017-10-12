=begin
    Ruby Std library has to be explicitly required in your classes, using the require keyword, to use them

    References:
    [1] http://ruby-doc.org/core-2.2.2/IO.html
    [2] http://ruby-doc.org/stdlib-2.2.2/libdoc/date/rdoc/Date.html
    [3] http://ruby-doc.org/core-2.2.2/Time.html
    [4] http://ruby-doc.org/stdlib-2.2.2/libdoc/json/rdoc/JSON.html
    [5] http://ruby-doc.org/stdlib-2.2.2/libdoc/yaml/rdoc/YAML.html
    [6] http://ruby-doc.org/stdlib-2.2.2/libdoc/base64/rdoc/Base64.html

Formatting date strings:

Date (Year, Month, Day):
  %Y - Year with century if provided, will pad result at least 4 digits.
          -0001, 0000, 1995, 2009, 14292, etc.
  %C - year / 100 (rounded down such as 20 in 2009)
  %y - year % 100 (00..99)

  %m - Month of the year, zero-padded (01..12)
          %_m  blank-padded ( 1..12)
          %-m  no-padded (1..12)
  %B - The full month name (``January'')
          %^B  uppercased (``JANUARY'')
  %b - The abbreviated month name (``Jan'')
          %^b  uppercased (``JAN'')
  %h - Equivalent to %b

  %d - Day of the month, zero-padded (01..31)
          %-d  no-padded (1..31)
  %e - Day of the month, blank-padded ( 1..31)

  %j - Day of the year (001..366)

=end

### Represent Date using Ruby Date Class ###

# the data class allows us to work with individual dates, but not time
require 'date' #=> -4712-01-01
# Instantiate a new date object:
puts Date.new
puts Date.new(2017, 3, 1) #=> 2017-03-01

# parse dates from strings
puts Date.parse("March 1st, 2017") #=> 2017-03-01
# Date.parse("It's 2015, everyone!") #=> 'invalid date' 
# puts Date.parse("2017") #=> 'invalid date' 

# manipulate dates
puts Date.today #=> 2017-06-27
puts Date.today + 1 #=> 2017-06-28
puts Date.today - 1 #=> 2017-06-26
puts Date.today << 1 # (subtract month) #=> 2017-05-27
puts Date.today >> 1 # (add month) #=> 2017-07-27
puts Date.today.strftime("%Y %m, %d") #=> 2017 06, 27
puts Date.today.strftime("%m %d, %Y") #=> 06 27, 2017


### DateTime and Time Classes ###

# adds support for time - there is litle difference between the two classes in modern Ruby
# the Time class is part of ruby core
puts Time.new #=> 2017-06-27 19:25:44 +0100
puts Time.new(2011) #=> 2017-06-27 19:25:44 +0100
puts Time.new(2014, 2, 1) #=> 2014-02-01 00:00:00 +0000

# assign the time to a variable, gives you access to the various components of time
puts time = Time.new #=> 2017-06-27 19:25:44 +0100
puts time.hour #=> 19
puts time.min #=> 25
puts time.sec #=> 44
puts time.monday? #=> false
puts time.month #=> 6
puts time.day #=> 27
time + 1 #=> adds one sec
time + 60 #=> adds one minute

# By default ruby uses the time zone where ever the pc is found
puts time = Time.new #=> 2017-06-27 19:25:44 +0100 (in this case )

# to specify the time zone
utc_time = Time.new(2017, 6, 27, 12, 0, 0, "-04:00")
puts utc_time #=> 2017-06-27 12:00:00 -0400

#convert time to utc
puts time.utc #=> 2017-06-27 18:46:04 UTC


### Reading/Writing JSON in Ruby ###
require 'json'

# to parse a json string to a ruby object
json_string = '{
    "name": "Tom Jones",
    "address": "1 the street, london, uk",
    "phone": "123-456-7896"
}'

user = JSON.parse(json_string)

puts json_string
puts user #=> {"name"=>"Tom Jones", "address"=>"1 the street, london, uk", "phone"=>"123-456-7896"}

# convert a ruby hash into a json string
user2 = {name: "John Paul jones", email: "jpjones@example.com", numbers: [1,2,3,4,5]}
puts JSON.dump(user2) #=> {"name":"John Paul jones","email":"jpjones@example.com","numbers":[1,2,3,4,5]}

# load json from a source such as a file
#JSON.load(File.new('./example.json')) #=> ruby hash


### YAML Yet Another Markup Language ###

# common serializtion format used in ruby projects
# often used to store app config and state
require 'yaml'

# convert ruby hash to yaml using the dump or to_yaml methods
puts YAML.dump(user2)
puts user2.to_yaml

# convert yaml to ruby hash using the load_file method
#YAML.load('./example.yml')


### Encode Binary Data using Base64 ###

# binary encoding scheme will represent binary data in a text format. 
# We mainly use this when sending binary data across a medium which expects text data, like when requesting web sites across a network. 
require 'base64'

# encode strings to base64 using the encode64 method
message = "Welcome to the Jungle"
encoded = Base64.encode64(message)
puts encoded

# decode base64 string using decode64 method
puts Base64.decode64(encoded)

# theres also urlsafe versions to handle data encoded in the url, uses ‘-’ instead of ‘+’ and ‘_’ instead of ‘/’.
result = Base64.urlsafe_encode64(message)
Base64.urlsafe_decode64(result)


### Logger ###

# Log data to Stream, stdout, network, file etc
require 'logger'

# log to stdout, and send different level messages
logger = Logger.new(STDOUT)
logger.info "info message" #=> I, [2017-06-27T20:38:11.340691 #31455]  INFO -- : info message 
logger.debug "debug....." #=> D, [2017-06-27T20:38:11.340796 #31455] DEBUG -- : debug.....
logger.warn "warning...." #=> W, [2017-06-27T20:38:11.340837 #31455]  WARN -- : warning.....
logger.fatal "fatal....." #=> F, [2017-06-27T20:38:11.340870 #31455] FATAL -- : fatal......

# to log to a text file
logger = Logger.new('./log.txt')
logger.info "info message" 
logger.debug "debug....." 
logger.warn "warning...." 
logger.fatal "fatal....."