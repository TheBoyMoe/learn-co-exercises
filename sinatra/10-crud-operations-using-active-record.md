## Implementing CRUD Operations using Active Record

Using the example of `Post` as our model, the basic CRUD operations are:

  * Create -> Post.create
  * Read -> Post.all/Post.find(id_number)
  * Update -> Post.update
  * Delete -> Post.destroy

These  four operations are implemented in Sinatra via 7 routes and controller actions as defined by Roy Fielding in his REST architecture design for networked software(2000):

**Create**

Requires 2 controller actions/routes - one route/controller action that renders a form allowing the user to define a new instance of the model, and a 2nd which extracts that data, creates the new instance and saves it to the database.

  * The `get '/post/new'` route renders the view page with that form.

  * The `new.erb` is the view page that contains that form.

  * That form sends a `POST` request to `post '/posts'` route. It is here, in it's controller action that you extract the form's data from the `params` hash and uses it to create a new instance of your model class e.g,

  ```ruby
    Post.create(title: params[:title], author: params[:author], content: params[:content])
  ```

**Read**

Requires 2 controller actions/ routes - one which return all instances of a class, and a 2nd to retrieve a specific instance of the model:

  * The `get '/posts'` controller action handles requests for *all* instances of a class. It returns an array of all instances and assigns it to an instance variable: `@posts = Post.all`, and renders the `index.erb` page to display the results to the user.

  * The `index.erb` view page will use erb to render all of the instances stored in the `@posts` instance variable.

  * The `get '/posts/:id'` controller action handles requests for a given instance of your model. The instance of the model with that id is retrieved and assigned to an instance variable: `@post = Post.find(params[:id])`. Finally, it will render the `show.erb` view page.

  * The `show.erb` view page will use erb to render the `@post` object.

NOTE: the order in which we define certain routes matters. Thus if we define `get /posts/:id` before `get /posts/new`, every request for `get /posts/new` will be routed to `get /posts/:id` causing an error to be thrown because Sinatra can not find an instance with the 'id' of 'new'. Ensure that '/posts/new' appears before '/posts/:id'.


**Update**

Requires two controller actions/routes - one to render an update form allowing the user to enter the necessary information, and a second to capture and process the post request.

  * The `get 'posts/:id/edit'` controller action will render the `edit.erb` view page.

  * The `edit.erb` view page will contain the form for editing a given instance of a model. This form will send a `PATCH` request to `patch '/posts/:id'`.

  * The `patch '/posts/:id'` controller action will find the instance of the model to update, using the `id` from `params`, update and save that instance.

NOTE: browsers don't support the `patch` method type, use the following work around.

  * update `config.ru` to use the Sinatra Middleware that lets our app send `patch` requests.

  ```ruby
    # config.ru
    use Rack::MethodOverride

    run ApplicationController
  ```

  * to add an `input` field to your form that includes `value="patch"` and `name="_method"`, the form still uses the `post` method, e.g

  ```html
    <!-- edit.erb -->
    <form action="/posts/<%= @post.id %>" method="post">
      <!-- changes the request from post to update -->
      <input id="hidden" type="hidden" name="_method" value="patch">
      <input type="text" ...>
      ...
      ...
    </form>  
  ```

  * The `MethodOverride` middleware will intercept every request sent and received by our application. If it finds a request with `name="_method"`, it will set the request type based on what is set in the `value` attribute, which in this case is `patch`, instead of using `post` - ensures the request is routed to the patch route.


**Delete**

I implemented with one route/controller action. It does not need a view page, being implemented with a single 'delete' button on the 'show' page of the instance to be deleted. The 'delete' button is actually a form that should send the 'DELETE' request to `delete /posts/:id/delete` via an 'input' field with the type of 'submit' and value of 'delete'. The form must include an 'input' field with `name=_method` and `value="delete"` for the 'delete' request to work.

NOTE:

  * add 'MethodOverride' setting to 'config.ru' file.

  * In order to make a form that looks like a button, all we need to do is make a form that has no input fields, only a "submit" button with a value of "delete".

```html
  <form method="post" action="/posts/<%= @post.id %>/delete">
    <!-- changes the request from post to delete -->
    <input id="hidden" type="hidden" name="_method" value="delete">
    <input type="submit" value="delete">
  </form>
```



### Summary
                                 retrieves            sends request
Create: `get /post/new`         ----------> new.erb   -------------> `post '/posts'`

Read:   `get 'posts'`           ----------> index.erb
        `get '/posts/:id'`      ----------> show.erb

Update: `get 'post/:id/:edit'`  ----------> edit.erb  ------------> `patch '/post/:id'`

Delete: `get /posts/:id`        ----------> show.erb  ------------> `post '/posts/:id/delete'`
