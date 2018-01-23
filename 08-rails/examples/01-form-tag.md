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