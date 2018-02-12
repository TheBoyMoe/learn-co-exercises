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
2. rails assumes that the partial is in the same folder as the view in which it is beinging referenced, add path if not
3. when using variables in partials, pass them in as locals from the view calling the partial. It may mean modifying the controller action to ensure that the variable is available.

