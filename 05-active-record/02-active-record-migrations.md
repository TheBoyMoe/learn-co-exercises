## Migrations and Active Record

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
