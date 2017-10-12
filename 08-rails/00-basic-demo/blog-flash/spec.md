## overview of the application

I want to be able to view a bunch of blog posts and perform CRUD operations on those posts

CRUD operations

GET /posts -> index action - list all the blog posts
GET /posts/:id -> show action - display a specific post
GET /posts/new -> new action - display a form allowing the user to create a new post
POST /posts -> create action - create the new blog post
GET /posts/:id/edit -> edit action - allow user to edit the blow post
POST /posts/:id -> update action - update the post
DELETE /posts/:id -> delete action - delete post


Migration operations generate the following:

scaffold -> Controller, routes, model, migration, views
resource -> Controller, routes, model, migration
controller -> Controller and view
model -> create model and migration (model and table )
migration -> just a migration


ActiveRecord conventions:

table name: lowercase plural name of model - posts
model file name: singular, lowercase(snakecase) - post.rb
class name of model: singular, camelcase - Post

table: authors
model: author.rb
class: Author
