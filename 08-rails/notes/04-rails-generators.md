## Rails Generators

[Rails generators](http://guides.rubyonrails.org/active_record_migrations.html)
[Rails Migration Api](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

### Abstract

- migration - migration file
- model(singular) - model and migration
- controller(plural) - controller, actions, routes and view for each action *
- resource(singular) - model, migration, controller(NO actions), routes, NO views *
- scaffold(singular) - full working CRUD based RESTful resource
										 - model, migration, controller(complete CRUD actions), routes, views(index, show, new, edit, _form) *

* plus helper and asset(scss, coffee script) files


### Migration generator

Creates the migration file required to create the database table
Run rails/rake db:migrate to create database table


```text
	# create a table
  rails g migration create_posts title:string content:text timestamp:string
  
  # add a column
  rails g migration add_post_status_to_posts post_status:boolean
  
  # remove a column
  rails g migration remove_timestamp_from_posts timestamp:string
   
  # change a column's data type - does not automatically add `change_column to migration, add it manually`
  rails g migration change_post_status_from_posts post_status:string 
```

### Model generator

Creates the model and associated migration
Run rails/rake db:migrate to create database table

```text
	rails g model Author name:string avatar:string bio:text
```

Adding foreign keys to your model - adds `belongs_to` relationship to song model for both artist and genre's.
- you need to add the reciprical `'has_many` relationship to both artist and genre model's.
- automatically adds the artist_id and genre_id columns in songs table

```text
	rails g model Song name:string artist:references genre:references 
```

```ruby
	 create_table "artists", force: :cascade do |t|
      t.string   "name"
      t.text     "bio"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "genres", force: :cascade do |t|
      t.string   "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "songs", force: :cascade do |t|
      t.string   "name"
      t.integer  "artist_id"
      t.integer  "genre_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
```


### Controller generator

Useful when creating static views or non-CRUD features
- append the controller name with the actions
- adds a method, a route and a view for each action(plus stylesheets & js files)
- NO model or migration is created

```text
	rails g controller Admin dashboard stats financials settings
```

### Resource generator 

Useful when creating a API for a front-end MVC framework.
- generates a controller, model, migration and adds the necessary routes using full `resources' call(adding default RESTful routes) 
- adds `view` directory, but NO view templates are created
- adds a view helper, scss and js files


```text
	rails g resource Account name:string payment_status:string
```


### Scaffold generator

Full working CRUD based RESTful resource

```text
	rails g scaffold Apartment address:string price:integer
```