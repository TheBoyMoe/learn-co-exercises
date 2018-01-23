## Form_for

- Automatically sets the path and method post/patch depending on whether the obj is pre-existing
- 'patch' updates only the items that have changed, 'put' updates the entire object.
- `|f|` is an iterator variable(FormBuilder object) that allows us to create form elements that correspond to attributes on the model.
- is directly connected to an active record model
 
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

------------------------------------------------------------------------------------------------------

## form_for vs form_tag example


### form_tag

```html
	<%= form_tag("/cats") do %>
    <%= label_tag('cat[name]', "Name") %>
    <%= text_field_tag('cat[name]') %>
   
    <%= label_tag('cat[color]', "Color") %>
    <%= text_field_tag('cat[color]') %>
   
    <%= submit_tag "Create Cat" %>
  <% end %>
```


```html
	<form accept-charset="UTF-8" action="/cats" method="POST">
    <label for="cat_name">Name</label>
    <input id="cat_name" name="cat[name]" type="text">
    <label for="cat_color">Color</label>
    <input id="cat_color" name="cat[color]" type="text">
    <input name="commit" type="submit" value="Create Cat">
  </form>
```


### form_for

```html
	<%= form_for(@cat) do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    <%= f.label :color %>
    <%= f.text_field :color %>
    <%= f.submit %>
  <% end %>
```

```html
	<!--generates the following html-->
	<form accept-charset="UTF-8" action="/cats" method="post">
    <label for="cat_name">Name</label>
    <input id="cat_name" name="cat[name]" type="text" />
    <label for="cat_color">Color</label>
    <input id="cat_color" name="cat[color]" type="text" />
    <input name="commit" type="submit" value="Create" />
  </form>
```