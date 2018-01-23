## Form_for

- Automatically sets the path and method post/patch depending on whether the obj is pre-existing
- 'patch' updates only the items that have changed, 'put' updates the entire object.
- `|f|` is an iterator variable that allows us to dynamically assign form fields to each of the objects data attributes.
 
```html
<!--basic form_for implementation-->
<%= form_for(@post) do |f| %>
  <label>Post title:</label><br>
  <%= f.text_field :title %><br>

  <label>Post Description</label><br>
  <%= f.text_area :description %><br>
  
  <%= f.submit %>
<% end %>
``` 

```html
<!--generated html-->

<form class="edit_post" id="edit_post_5" action="/posts/5" accept-charset="UTF-8" method="post">
	<!--removed hidden fields-->
  <label for="post_title">Post title:</label><br>
  <input type="text" value="post number 5" name="post[title]" id="post_title" /><br>

  <label for="post_description">Post Description</label><br>
  <textarea name="post[description]" id="post_description">rtyrtyrty</textarea><br>
  
  <input type="submit" name="commit" value="Update Post" />
</form>
```



```ruby
# posts controller
 def update
		# @post.update(title: params[:post][:title], description: params[:post][:description])
		@post.update(params.require(:post))
		redirect_to post_path(@post)
	end 
```
