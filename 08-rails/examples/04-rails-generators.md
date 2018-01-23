## Rails Generators

[Rails generators](http://guides.rubyonrails.org/active_record_migrations.html)
[Rails Migration Api](http://api.rubyonrails.org/classes/ActiveRecord/Migration.html)

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