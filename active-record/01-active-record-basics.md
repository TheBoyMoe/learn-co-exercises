## Active Record

Active Record represents the Model layer in the MVC pattern - responsible for implementing business data and logic. Active Record is the implementation of a design pattern which facilitates the creation, use and storage of business objects. It is itself an ORM system, enabling those object classes and attributes to be mapped to database tables and columns respectively. By following the adopted conventions, there is very little SQL code that need be written. Most Active Record functionality is database independent. Since you're doing everything in Ruby instead of SQl, you don't have to worry about particular SQL syntax - so you can use SQLite3 in development and MySQL or PostgreSql in production.

### Implementing Active Record

Active Record is a Ruby gem, so include it in your Gemfile. In the config/environment.rb add a connection to the database

```ruby
  conn = ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'db/students.sqlite'
    )}
```

In your class file, create your sql table:

```ruby
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT
  )
  SQL
  ActiveRecord::Base.conn.execute(sql)
```

To make use of ActiveRecord's built in ORM methods, ensure that your ruby class inherit from ActiveRecord::Base class.

```ruby
  class Student < ActiveRecord::Base
  end
```

Inheriting from ActiveRecord in this manner creates the Student model, which is mapped to the students database, and the column names map to the instance's attributes. Your model will also inherit an number of methods.


### Available CRUD Methods

#### create

Active Record objects can be created from a hash, a block or have their attributes manually set after creation. The new method will return a new object while create will return the object and save it to the database.

```ruby
  # retrieve all column names
  Student.column_names #=> [:id, :name]

  # create a new student record in the database
  # "INSERT INTO students (name) VALUES (John)";
  student1 = Student.create(name: 'John') #=> returns instance of class

  # to create a record if it does not already exist
  student2 =  Student.find_or_create_by({name: 'John'}) #=> returns instance of class
  student1.id == student2.id

  #  given a model User with attributes of name and occupation, the create method call will create and save a new record into the database:
  user = User.create(name: "David", occupation: "Code Artist")

  # Using the new method, an object can be instantiated without being saved:
  user = User.new
  user.name = "David"
  user.occupation = "Code Artist"
  user.save # commit to the database

  # You can create a user using a block. Where a block is provided, both create and new will yield the new object to that block for initialization:
  user = User.new do |u|
    u.name = "David"
    u.occupation = "Code Artist"
  end
```


#### Read

```ruby

  # return a collection with all users
  users = User.all

  # return the first user
  user = User.first

  # retrieve a record by id
  # "SELECT * FROM students WHERE id = 1";
  Student.find(1) #=> returns instance of class

  # retrieve a record by any of it's attributes, e.g. name, returning the first match
  # "SELECT * FROM students WHERE name = 'John' LIMIT 1";
  Student.find_by(name: 'John') #=> returns instance of class

  # retrieve a record based on multiple attributes
  Movie.find_by(title: 'The Sting', release_date: 1973, director: 'George Roy Hill')

  # there's also, .find_by_[attr_name], e.g
  Student.find_by_name('John') #=> returns instance of class
  Student.find_by_id(1) #=> returns instance of class


  # find all users named David who are Code Artists and sort by created_at in reverse chronological order
  users = User.where(name: 'David', occupation: 'Code Artist').order(created_at: :desc)
```
#### Update

```ruby
  # getters/setters of an instance
  # there's no need to define attr_accessors
  student = Student.find_by_name('John')
  student.name #=> 'John'
  student.name = 'Peter'
  student.name #=> 'Peter'

  # save changes to the database
  student.save

  # to update and save a record in one step
  student.update({name: 'Simon'})
  student.name #=> 'Simon'

  # There's also the .update_all class method, for bulk updates
  User.update_all "max_login_attempts = 3, must_change_password = 'true'"
  Movie.update_all(title: 'A Movie')
```

#### Delete

To delete a record from the database, first retrieve it, before 'destroying' it

```ruby
  user = User.find_by(name: 'John')
  user.destroy
```

Destroy all records at once

```ruby
  Movie.destroy_all
```


### References
1. [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
2. [Querying Active Record](http://guides.rubyonrails.org/active_record_querying.html)
3. [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html#writing-a-migration)
4. [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
