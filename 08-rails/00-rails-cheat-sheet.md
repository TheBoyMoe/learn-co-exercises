## Cheatsheet

### Rails

*generate a controller*

$ rails generate controller [controller_name] [action_name] ...

*display routing table*

rails routes





### Erb

*link to*

<%= link_to([link_text], [route]) %>
<%= link_to("About page", '/about') %>  => <a href="/about">About page</a>

use route helpers so as not to hard code route string(append `_path`)
<%= link_to([link_text], [route_helper]) %>
<%= link_to("About page", about_path) %>  => <a href="/about">About page</a>
