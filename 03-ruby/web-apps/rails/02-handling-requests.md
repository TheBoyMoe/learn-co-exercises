## Handling requests in Rails

### Overview
 * Rails looks at the request, to figure out which code should handle it.  
 * The request gets routed to an action method on a "controller".  
 * The controller loads the resource in from database using a "model class".  
 * The controller renders a "view" using the model data, to generate the response content.  

Examining the logs we can see Rails recieving a GET request, passing it to a controller, loading some model data, and rendering a view:

```text
    Started GET "/posts" for ::1 at 2016-05-28 12:37:31 -0700
    Processing by PostsController#index as HTML
        Rendering posts/index.html.erb within layouts/application
        Post Load (0.1ms)  SELECT "posts".* FROM "posts"
        Rendered posts/index.html.erb within layouts/application (1.6ms)
    Completed 200 OK in 23ms (Views: 20.2ms | ActiveRecord: 0.1ms)
`````
### Controller

The controller is responsible for handling the browser request. It controls the model and the view to generate a response. When you access the list of all "Post" objects, the request gets sent to the "index" method of the "PostsController" class.

 * Rails creates the source code for controller classes in the "app/controllers/" subdirectory. 
 * The "PostsController" class will be in "posts_controller.rb".  
 * The request is handled by the "index" method or action (controller methods that respond to requests are sometimes called "actions").  

Most of the code for your app is found in the app sub-directory, where you'll find sub-folders for views, models and controllers. Within controllers you'll find the posts_controller.rb file, which is the PostsController class which defines the index method.

### Model

The model is responsible for storing and retrieving data from users of your app, and are found in the app/model sub-folder. Model classes are ruby classes. These classes have one or more attributes that reference data you need to keep track of, e.g the @posts instance variable has a reference to a list of all the posts returned by Post.all. The class is a sub-class of the ApplicationController class and so inherits it's methods, such as save, delete, all, new, find ,etc. Rails generates the SQL queries for you. Each database record retrieved is used to instantiate a ruby class, the database column values of a record are set as the attribute values of the instantiated object.

### View

The view is responsible for displaying data to users. Views usually take the form of HTML templates(which can be found in the app/views subfolder - within that folder, they're placed within another folder named after the current resource) with Ruby expressions embedded in them. Those expressions refer to data loaded from the model, and are used to populate an HTML page with that data which is returned to the browser as a response to the request.