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


### Available Methods

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

### Rake and Rake tasks

Rake is a tool, available as a Ruby gem, that allows you to automate routine jobs such as creating a database table, importing seed data into the database. Rake provide a standard way to define and execute such tasks.

To create a task, or 'Rake task', add a 'Rakefile' to the top level directory of your project, and define a task. e.g.

```ruby
  task :hello do
    # code to be executed
    puts 'Hello from Rake!'
  end
```

Tasks start with the task keyword, followed by the task name represented as a symbol and a block that contains the code to be executed. Execute a task from the cli:

```ruby
  rake hello
```

We can view a list of the available Rake tasks for the particular app by calling 'rake -T' from the cli - depends on giving each task a description:

```ruby
  desc 'outputs hello to the terminal'
  task :hello do
    puts 'Hello from Rake!'
  end

  # executing 'rake -T' outputs
  rake hello    # 'outputs hello to the terminal'
```

We can also group rake tasks together when they're related by using a namespace, e.g.

```ruby
  namespace :greeting do
  desc 'outputs hello to the terminal'
    task :hello do
      puts "hello from Rake!"
    end

    desc 'outputs hola to the terminal'
    task :hola do
      puts "hola de Rake!"
    end
  end

  # to use either task
  rake greeting:hello

  rake greeting:hola
```

Rake tasks are often used to create database tables and seed them with dummy data:

```ruby
  namespace :db do
    desc 'migrate changes to your database'
    task :migrate => :environment do
      Student.create_table
    end

    desc 'seed the database with some dummy data'
    task :seed do
      require_relative './db/seeds.rb'
    end
  end

  desc 'load the environment'
  task :environment do
    require_relative './config/environment'
  end
```

Where the seed data, 'db/seeds.rb'

```ruby
  require_relative "../lib/student.rb"

  Student.create(name: "Melissa", grade: "10th")
  Student.create(name: "April", grade: "10th")
  Student.create(name: "Luke", grade: "9th")
  Student.create(name: "Devon", grade: "11th")
  Student.create(name: "Sarah", grade: "10th")
```

And 'config/environment.rb'

```ruby
  require 'sqlite3'
  require 'pry'

  require_relative "../lib/student.rb"

  DB = {:conn => SQLite3::Database.new("db/students.db")}
```

To create the database table and then seed it:

```ruby
  rake db:migrate
  rake db:seed
```

The db:migrate task has a dependency upon the environment task, 'task :migrate => :environment', the environment task needs to execute before the migrate task so that all the proper environment files are loaded.


Another common Rake task is to provide a pry console in order to debug the app, loading the environment first ensuring that all necessary files or necessary processes (e.g. database connections) are loaded first.

```ruby
  desc 'drop into the Pry console'
  task :console => :environment do
    Pry.start
  end  
```

Provided the db:seed and db:migrate commands are run first, when you execute 'rake console' you'll be dropped in to pry and have access to the database table.


### Migrations and Active Record

ActiveRecord allows you to create a database that your classes can interact with, with only a few lines of code. Your models inherit from ActiveRecord::Base and are placed in app/models folder. Migrations inherit from ActiveRecord::Migration and are placed in db/migrate.

Note: as of ActiveRecord5.x, you need to include the version number when inheriting from ActiveRecord::Migration, e.g. ActiveRecord::Migration[4.2]

Note: the t.timestamps create two columns, created_at and updated_at

```ruby

  # migration
  class CreateDogs < ActiveRecord::Migration[4.2]
    def change
      create_table :dogs do |t|
        t.string :name
        t.string :breed
        t.timestamps
      end
    end
  end

  # model
  class Dog < ActiveRecord::Base; end

  # to create the database & make ActiveRecords CRUD/ORM methods available
  rake db:migrate
```

Note: after db:migrate has been applied, do not add columns to the change method above directly. Instead, create a new migration file with a change method and use the 'add_column' statement and run db:migrate once more. Number the files 01_, 02_, etc so that they're applied in sequence, in the correct order, e.g. create_table first, amendment second.

Migrate files use a naming convention, where the name of the class (in camel case) matches that of the file (in snake case), ignoring any numbers at the beginning of the file. Rails uses a timestamp in the format YYYYMMDDHHMMSS, in order to determine the order in which the files should be executed.

Database migrations is a simple, convenient way to configure/alter your database in a structured and organised manner using Ruby. You can alter the configuration of you database at a later date without losing data. Active Record keeps track of these changes, so you can revert those changes.

#### Active Record Datatypes

|Data Type                      |Examples                                                      |
|-------------------------------|--------------------------------------------------------------|
|boolean                        | true, false (sqlite3 uses 0 - false, 1 - true)               |
|integer                        | 2, -13, 485                                                  |
|string                         | "Halloween", "Boo!", strings between 1-255 characters        |
|datetime                       | DateTime.now, DateTime.new(2014,10,31) (sqlite3 uses strings)|
|float                          | 2.234, 32.2124, -6.342 (sqlite3 uses REAL)                   |
|text                           | strings between 1 and 2 ^ 32 - 1 characters                  |


### Querying Active Record

Active Record provides a number of methods for retrieving one or more records from the database.

```ruby
  User.take #=> retrieves a row from the database, returns nil otherwise

  # equivalent => 'SELECT * FROM users LIMIT 1'

  User.take(4) #=> returns an array with that number of records

  # equivalent => 'SELECT * FROM users LIMIT 4'

  User.first #=> retrieves the first row in the database (ordered by id), returns nil otherwise

  # equivalent 'SELECT * FROM clients ORDER BY clients.id ASC LIMIT 1'

  User.first(4)  #=> returns an array with that number of records

  # equivalent 'SELECT * FROM clients ORDER BY clients.id ASC LIMIT 4'

  User.order(:name).first #=> return 1st record ordered by specified attribute

  # equivalent 'SELECT * FROM clients ORDER BY clients.first_name ASC LIMIT 1'

  User.last #=> retrieves the last row in the database (ordered by id), returns nil otherwise

  # equivalent 'SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1'

  User.where('subject = ?, location = ?', arg1, arg2) # arguments replace the question marks in the order given
  User.where(subject: 'biology', location: 'London') # you can pass in hash key/value pairs

  # equivalent 'SELECT * FROM users WHERE subject = ? AND location = ?'  

  User.where.not(subject: 'biology')

  # you can retrieve records in a specific order
  User.order(:created_at)
  User.order('created_at')

  User.order(created_at: :desc)
  User.order('created_at DESC')

  User.order(orders_count: :asc, created_at: :desc)
  User.order("orders_count ASC", "created_at DESC")

  User.where('id > 10').limit(20).order('id asc')
```

#### Retrieving Multiple Records

Where your dataset is less than 1000 records, use the #each method, .e.g.

```ruby
  User.all.each do |user|
    NewsMailer.weekly(user).deliver_now
  end
```

As the table size increases, this technique becomes impracticle due to the hit on performance. User.all.each instructs ActiveRecord to fetch the entire table in a single pass, build a model object per row, and then keep the entire array of model objects in memory. ActiveRecord provides 2 methods to overcome this limitation:

1. find_each - retrieves records in batches of 1000, then yields them one at a time into the block. More batches are fetched as needed, until all records have been processed.

```ruby
  User.find_each do |user|
    NewsMailer.weekly(user).deliver_now
  end

  # do NOT employ ordering
  User.where(weekly_subscriber: true).find_each do |user|
    NewsMailer.weekly(user).deliver_now
  end
```

You can employ a number of options

```ruby

# retrieve batches of 5000
User.find_each(batch_size: 5000) do |user|
  NewsMailer.weekly(user).deliver_now
end

# ordinarily records are returned in ascending order from the lowest id, use 'start:' to set the start id. You can also use 'finish:' to set the last id.
User.find_each(start: 2000) do |user|
  NewsMailer.weekly(user).deliver_now
end

# use 'start:' and 'finish:' to process a subset
User.find_each(start: 2000, finish: 10000) do |user|
  NewsMailer.weekly(user).deliver_now
end
```

#### Calculations

The following methods are available: count, average, minimum, maximum and sum. You can use these in combination with where, include, etc.

```ruby
  User.count
  User.where(subject: 'Biology').count
  User.includes('orders').where(status: 'received').count
  User.sum('orders_count')
  User.average('age')
  User.minimum('age')
  User.maximum('age')
```


### References
1. [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
2. [Querying Active Record](http://guides.rubyonrails.org/active_record_querying.html)
3. [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html#writing-a-migration)
