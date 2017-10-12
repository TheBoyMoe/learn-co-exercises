## REST Architecture

Any app which intends to make available a resource via REST should include the following URL schema (Rails 2.0 was the first web framework to use such a schema)

1. GET /photos #=> index, list all examples of the resource
2. GET /photos/1 #=> show, show the particular resource based on id

3. GET /photos/new #=> new, should present a form allowing the user to create a new item(calls POST /photos on submission)
4. POST /photos #=> create, adds the new item to the application

5. GET /photos/1/edit #=> edit, present a form allowing the user to edit the item(calls PUT /photos/1 on submission)
6. PATCH /photos/1 #=> update, updates the item in the app

7. DELETE /photos/1 #=> destroy, delete the item from the app


A RESTful route maps a HTTP verbs (get, post, put, delete, patch) to CRUD actions (create, read, update, delete) - a route consists if the verb and url of the resource. When your app receives a http request it determines the http verb and url, then identifies the matching route and executes the corresponding controller action. Browsers are only aware of the 'GET' and 'POST' verbs. Thus workarounds need to be implemented when you need to use 'DELETE', 'PUT', or 'PATCH'.


## Routes and Actions

| HTTP VERB       | ROUTE               | Action        | Used For |

| GET             | '/posts'            | index action  | display all posts |
| GET             | '/posts/:id'        | show action   | displays a single post based on ID |
| GET             | '/posts/new'        | new action    | display a form allowing user to enter data |
| POST            | '/posts'            | create action | create a post |
| GET             | '/posts/:id/edit'   | edit action   | display a form allowing user to edit post |
| PATCH(use POST) | '/posts/:id'        | update action | edits blog post based on ID |
| DELETE(use POST)| '/posts/:id/delete' | delete action | deletes blog post based on ID |  


### Index Action

```ruby
  # retrieve all posts, making them accessible to the 'index' view through the '@posts' instance variable
  get '/posts' do
    @posts = Post.all

    erb :'posts/index'
  end
```


### New Action

```ruby
  # render a form to create a new post
  get '/posts/new' do
    erb :'posts/new'
  end
```

### Create Action

```ruby
  # create a new post based on the params hash, save it and redirect the user to the 'show' page
  post '/posts' do
    post = Post.create(:title => params[:title], :content => params[:content])

    redirect to '/posts/#{post.id}' # show action
  end
```

### Show Action

```ruby
  # fetch the appropriate post and render the 'show' view displaying the post
  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])

    erb :'posts/show'
  end
```

### Edit Action

```ruby
  # load edit form
  get '/posts/:id/edit' do  
    @post = Post.find_by_id(params[:id])

    erb :'posts/edit'
  end
```

### Update Action

```ruby
# fetch the post based on it's id, update it's attributes before saving the updated post
# redirect the user to the post's show page
patch '/posts/:id' do
  post = Post.find_by_id(params[:id])
  post.title = params[:title]
  post.content = params[:content]
  post.save
  redirect to "/posts/#{post.id}" # show action
end
```

NOTE: browsers don't support the 'PATCH', 'DELETE' or 'PUT' verbs

  1. include a hidden 'input' line in your form with the value attribute set to the verb you want to implement, e.g. `<input id="hidden" type="hidden" name="_method" value="patch">`.

  2. add the following line to `config.ru` file - `use Rack::MethodOverride`, above the `run ApplicationController` line. 'Rack' will translate any requests with the `name="_method"` into whatever is set in the `value` attribute.

```ruby
  # example form
  <form action="/posts/<%= @post.id %>" method="post">
    <input id="hidden" type="hidden" name="_method" value="patch">
    <input type="text" name="title">
    <input type="text" name="content">
    <input type="submit" value="submit">
  </form>

  # example config.ru
  ...
  ...
  use Rack::MethodOverride
  use PostsController
  use SessionsController
  run ApplicationController
```

### Delete Action

```ruby
  delete '/posts/:id/delete' do
    post = Post.find_by_id(params[:id])
    post.delete

    redirect to '/posts' # index action
  end
```

Delete is implemented as 'button' - input field with `type="submit"`. As with 'UPDATE' action, add a hidden 'input' field with `value="delete"`.

```ruby
  <form action="/posts/<%= @post.id/delete %>" method="post">
    <input id="hidden" type="hidden" name="_method" value="delete">
    <input type="text" name="title">
    <input type="text" name="content">
    <input type="submit" value="submit">
  </form>
```
