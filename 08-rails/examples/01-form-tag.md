## new template using the html form element


```html
<%= form_tag students_path, method: 'post' do %>

	<!--return individual key/value pairs-->
	<label for="first_name">First Name:</label><br>
	<%= text_field_tag :first_name %><br><br>
	
	<!--produces the following html-->
	<!--<input type="text" name="first_name" id="first_name" />-->


	<label for="last_name">Last Name:</label><br>
	<%= text_field_tag :last_name %><br><br>

	<%= submit_tag 'Submit Student' %>

<% end %>
```

```ruby
	# controller action
 	 def create
      @student = Student.create(first_name: params[:first_name], last_name: params[:last_name])
      redirect_to student_path(@student)
   end 
```

---------------------------------------------------------------------------------------

## new form template using the form_teg

Use the form_tag when creating a search field or contact form

```html
<%= form_tag students_path, method: 'post' do %>

	<!--return a student hash with key/value pairs-->
	<label for="student_first_name">First Name:</label><br>
	<%= text_field_tag 'student[first_name]' %>
	
	<!--produces the following html-->
	<!--<input type="text" name="student[first_name]" id="student_first_name" />-->


	<label for="student_last_name">Last Name:</label><br>
	<%= text_field_tag 'student[last_name]' %><br><br>
	
	<!--produces the following html-->
  <!--<input type="text" name="student[last_name]" id="student_last_name" />-->

	<%= submit_tag 'Submit Student' %>

<% end %>
```

```ruby
	# controller action
  def create
		 @student = Student.create(first_name: params[:@student][:first_name], last_name: params[:student][:last_name])
		 redirect_to student_path(@student)
	end
```


---------------------------------------------------------------------------------------------------------------

## edit template using the form_tag

```html
	<%= form_tag post_path(@post), method: 'put' do %>
		<label>Post title:</label><br>
		<%= text_field_tag :title, @post.title %><br><br>
	
		<label>Post Description</label><br>
		<%= text_area_tag :description, @post.description %><br><br>
	
		<%= submit_tag "Submit Post" %>
	<% end %>
```

```ruby
# controller action
	def update
		@post = Post.find(params[:id])
		if @post.update(title: params[:title], description: params[:description])
			redirect_to post_path(@post)
		else
			render :edit
		end
	end 
  
```


------------------------------------------------------------------------------------------------------------
## form_tag example

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

------------------------------------------------------------------------------------------------------------

## form_tag example including display of validation errors to the user

```html
	<!--display error validation errors to user at top-->
  <% if @author.errors.any? %>
    <div id="error_explanation">
      <h2>There were some errors:</h2>
      <ul>
        <% @author.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
  
  <!--display form - highlighting any fields in error-->
  <%= form_tag authors_path, method: "post" do %>
    <div class="field<%= ' field_with_errors' if @author.errors[:name].any? %>">
      <%= label_tag "name", "Name" %>
      <%= text_field_tag "name", @author.name %>
    </div>
    <div class="field<%= ' field_with_errors' if @author.errors[:email].any? %>">
      <%= label_tag "email", "Email" %>
      <%= text_field_tag "email", @author.email %>
    </div>
    <%= submit_tag "Create Author" %>
  <% end %>

```

Resulting html (with error)

```html
	<div id="error_explanation">
		<h2>There were some errors:</h2>
		<ul>
				<li>Name does not allow numbers</li>
		</ul>
	</div>
    
	<form action="/authors" accept-charset="UTF-8" method="post">
		
		<!--name field-->
    <div class="field field_with_errors">
      <label for="name">Name</label>
      <input type="text" name="name" id="name" value="werw34" />
    </div>
    
    <!--email field-->
    <div class="field">
      <label for="email">Email</label>
      <input type="text" name="email" id="email" value="werwer" />
    </div>
    
    <input type="submit" name="commit" value="Create Author" />
  </form>

```




### form_tag used in new.html.erb for author object

```html
	<% if @author.errors.any? %>
    <div id="error_explanation">
      <h2>There were some errors:</h2>
      <ul>
        <% @author.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
  
  <%= form_tag authors_path, method: "post" do %>
    
    <div class="field<%= ' field_with_errors' if @author.errors[:name].any? %>">
      <%= label_tag "name", "Name" %>
      <%= text_field_tag "name", @author.name %>
    </div>
  
    <div class="field<%= ' field_with_errors' if @author.errors[:email].any? %>">
      <%= label_tag "email", "Email" %>
      <%= text_field_tag "email", @author.email %>
    </div>
  
    <div class="field<%= ' field_with_errors' if @author.errors[:phone_number].any? %>">
      <%= label_tag "phone_number", "Phone Number" %>
      <%= text_field_tag "phone_number", @author.phone_number %>
    </div>
  
    <%= submit_tag "Create" %>
  <% end %>
```


Resulting html (with errors)


```html
	<div id="error_explanation">
      <h2>There were some errors:</h2>
      <ul>
          <li>Name can&#39;t be blank</li>
          <li>Phone number is the wrong length (should be 10 characters)</li>
      </ul>
    </div>
  
  <form action="/authors" accept-charset="UTF-8" method="post">
  
    <div class="field field_with_errors">
      <label for="name">Name</label>
      <input type="text" name="name" id="name" value="......" />
    </div>
  
    <div class="field">
      <label for="email">Email</label>
      <input type="text" name="email" id="email" value="....." />
    </div>
  
    <div class="field field_with_errors">
      <label for="phone_number">Phone Number</label>
      <input type="text" name="phone_number" id="phone_number" value="....." />
    </div>
  
    <input type="submit" name="commit" value="Create" />
  </form>

```


### form_tag used in edit.html.erb for post object


```html
	<% if @post.errors.any? %>
    <div id="error_explanation">
      <h2>There were some errors:</h2>
      <ul>
        <% @post.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
  
  <%= form_tag post_path(@post), method: "patch" do %>
  
    <div class="field<%= ' field_with_errors' if @post.errors[:title].any? %>">
      <%= label_tag "title", "Title" %>
      <%= text_field_tag "title", @post.title %>
    </div>
  
    <div class="field<%= ' field_with_errors' if @post.errors[:category].any? %>">
      <%= label_tag "category", "Category" %>
      <p>Must be either "Fiction" or "Non-Fiction".</p>
      <%= text_field_tag "category", @post.category %>
      <p>
        Please type carefully as our top scientists are working around the clock to
        enable state-of-the-art dropdown technology for this form field.
      </p>
    </div>
  
    <div class="field<%= ' field_with_errors' if @post.errors[:content].any? %>">
      <%= label_tag "content", "Content" %>
      <br />
      <%= text_area_tag "content", @post.content %>
    </div>
    <%= submit_tag "Update" %>
  <% end %>
  
```


Resulting html (values are empty strings on a blank form, instance values are nil)


```html
	<form action="/posts/1" accept-charset="UTF-8" method="post">
  
    <div class="field">
      <label for="title">Title</label>
      <input type="text" name="title" id="title" value="" />
    </div>
  
    <div class="field">
      <label for="category">Category</label>
      <p>Must be either "Fiction" or "Non-Fiction".</p>
      <input type="text" name="category" id="category" value="" />
      <p>
        Please type carefully as our top scientists are working around the clock to
        enable state-of-the-art dropdown technology for this form field.
      </p>
    </div>
  
    <div class="field">
      <label for="content">Content</label>
      <br />
      <textarea name="content" id="content">......</div>
    <input type="submit" name="commit" value="Update" />
  </form>
```
