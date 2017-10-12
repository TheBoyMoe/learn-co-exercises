## Rake and Rake tasks

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
