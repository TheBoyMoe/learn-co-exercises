## Active Record

Active Record represents the Model layer in the MVC pattern - responsible for implementing business data and logic. Active Record is the implementation of a design pattern which facilitates the creation, use and storage of business objects. It is itself an ORM system, enabling those object classes and attributes to be mapped to database tables and columns respectively. By following the adopted conventions, there is very little SQL code that need be written.

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

### Available Methods

```ruby
  # retrieve all column names
  Student.column_names #=> [:id, :name]

  # create a new student record in the database
  # "INSERT INTO students (name) VALUES (John)";
  student1 = Student.create(name: 'John') #=> returns instance of class

  # to create a record if it does not already exist
  student2 =  Student.find_or_create_by({name: 'John'}) #=> returns instance of class
  student1.id == student2.id

  # retrieve a record by id
  # "SELECT * FROM students WHERE id = 1";
  Student.find(1) #=> returns instance of class

  # retrieve a record by any of it's attributes, e.g. name
  # "SELECT * FROM students WHERE name = 'John' LIMIT 1";
  Student.find_by(name: 'John') #=> returns instance of class

  # there's also, .find_by_[attr_name], e.g
  Student.find_by_name('John') #=> returns instance of class
  Student.find_by_id(1) #=> returns instance of class

  # getters/setters of an instance
  # there's no need to define attr_accessors
  student.name #=> 'John'
  student.name = 'Peter'
  student.name #=> 'Peter'

  # save changes to the database
  student.save

  # to update and save a record in one step
  student.update({name: 'Simon'})
  student.name #=> 'Simon'
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


### References
1. [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
2. [Querying Active Record](http://guides.rubyonrails.org/active_record_querying.html)
