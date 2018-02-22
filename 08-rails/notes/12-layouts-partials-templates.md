## Layouts

Rails follows the following rules when loading layouts:
1. has a specific layout been set in the controller, e.g. 


```ruby
	class ProductsController < ApplicationController
	
		layout 'products'
		
	end
```

You can specify a specific layout in the action(as well as the controller). Otherwise rails falls back to 2 and 3 for the remaining.

```ruby
	class ProductsController < ApplicationController
		
		layout 'alternate'
		
		def about
		  render layout: 'about_alt'
		end
		
		# to render an action without a template
 		def contact
 		  render layout: false
 		end 
	end
```

2. rails looks in the /app/views/layouts folder for a file whose name matches the layout, e.g. ProductsController -> layouts/products.html.erb

3. falls back to app/views/layouts/application/html/erb 


## Partials

1. start the file name with '_'
2. rails assumes that the partial is in the same folder as the view in which it is beginning referenced, add path if not
3. when using variables in partials, pass them in as locals from the view calling the partial.

```erb
	# we're no longer passing a string to 'render', e.g `render 'author'`.
	# instead we're passing a hash with 2 key/value pairs, the second arg is itself a hash
	# when using locals, make sure that the variables refered to in the partial have the same names as the keys in the locals hash.
	# using locals also means your more explicit about the dependencies the partial depends on
		
	
	<h1><%= @post.title %></h1>
  <p><%= @post.description %></p>
  
  <%= render partial: 'authors/authors', locals: {author: @post.author} %>
  
  <br>
  <%= link_to 'Back', posts_path %>
```

### Rendering collections

So far we have rendered collections by iterating over them, e.g.

```erb
	<% @posts.each do |post| %>
    <%= render :partial => "post", {:locals => {:post => post}} %>
  <% end %>
```

Rails provides the `collection` keyword to simplify the implementation

```erb
	<%= render partial: 'post', collection: @posts %>
```

A more simplified version(depends on having a partial named after the model)

```erb
	<%= render @posts %>
```

This technique also allows you to handle empty collections - you must use `render()`

```erb
	<%= render(@posts) || "There are no blog posts"  %>
```

### Example Navbar

```html
 <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		<a class="navbar-brand" href="<%= root_url %>"/>Home</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<!--navigation depends on Devise being installed-->
				<% if user_signed_in? %>
					<li><%= link_to "Sign out", destroy_user_session_path, method: :delete %></li>
				<% else %>
					<li><%= link_to 'Sign up', new_user_registration_path %></li>
					<li><%= link_to 'Sign in', new_user_session_path %></li>
				<% end %>
			</ul>
		</div><!--/.nav-collapse -->
	</div>
</div>

```