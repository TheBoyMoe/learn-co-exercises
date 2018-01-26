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
    <input type="text" name="cat[name]" id="cat_name" />
    
    <label for="cat_color">Color</label>
    <input type="text" name="cat[color]" id="cat_color" />
    
    <input name="commit" type="submit" value="Create" />
  </form>
```



### form_for example with check-box

```html
	<% if song.errors.any? %>
  	<div id="error_explanation">
  		<h3>There were some errors:</h3>
  		<ul>
  			<% song.errors.full_messages.each do |message| %>
  				<li><%= message %></li>
  			<% end %>
  		</ul>
  	</div>
  <% end %>

	<%= form_for(song) do |f| %>
  	<%= f.label :title %>
  	<%= f.text_field :title %><br>
  
  	<%= f.label :artist_name %>
  	<%= f.text_field :artist_name %><br>
  
  	<%= f.label :release_year %>
  	<%= f.text_field :release_year %><br>
  
  	<%= f.label :released %>
  	<%= f.check_box :released %><br>
  
  	<%= f.label :genre %>
  	<%= f.text_field :genre %><br>
  
  	<%= f.submit %>
  <% end %>
```

Generated html

```html
	<form class="new_song" id="new_song" action="/songs" accept-charset="UTF-8" method="post">
  	<label for="song_title">Title</label>
  	<input type="text" name="song[title]" id="song_title" /><br>
  
  	<label for="song_artist_name">Artist name</label>
  	<input type="text" name="song[artist_name]" id="song_artist_name" /><br>
  
  	<label for="song_release_year">Release year</label>
  	<input type="text" name="song[release_year]" id="song_release_year" /><br>
  
  	<label for="song_released">Released</label>
  	<input name="song[released]" type="hidden" value="0" /><input type="checkbox" value="1" name="song[released]" id="song_released" /><br>
  
  	<label for="song_genre">Genre</label>
  	<input type="text" name="song[genre]" id="song_genre" /><br>
  
  	<input type="submit" name="commit" value="Create Song" />
  </form>
```