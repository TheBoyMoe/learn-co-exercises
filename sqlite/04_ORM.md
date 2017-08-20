## ORM

Object Relational Mapping (ORM) is simply a technique of 'mapping' ruby classes and instances to SQL tables and rows respectively. Classes are equated with tables and instances with rows. The class is mapped to a table, not the database - we may want to add other tables/classes later. It's a design pattern. Thus ensuring that code is better organised and avoids code duplication. Thus a Cat class is mapped to a cats (convention to pluralize class name) table. Each cat instance is stored as(mapped to) a row, the individual property values mapping to column fields.

A simple class that saves instances of the 'Cat' class might look like this:

```ruby
class Cat
  attr_accessor :name, :breed, :age
  @@all = []

  def initialize(name, breed, age)
    @name = name
    @breed = breed
    @age = age
    @@all << self
  end

  def self.all
    @@all
  end

  def self.save(name, breed, age, database_connection)
    database_connection.execute("INSERT INTO cats (name, breed, age) VALUES (?, ?, ?)",name, breed, age)
  end
end

```

To create and save some cat instances to the database:

```sql
database_connection = SQLite3::Database.new('db/pets.db')

Cat.new("Mary", "Scottish fold", 3)
Cat.new("Hanna", "tortoiseshell", 1)

Cat.all.each do |cat|
  Cat.save(cat.name, cat.breed, cat.age, database_connection)
end
```

First establish the connection, create the instances and then iterate over the Cat instances stored in @@all. The .save method calling 'INSERT INTO' for each instance.


### Creating the Database and Table

The class is responsible for mapping to the database table, not for creating the database. In our program we'll have a 'config' folder that contains an 'environment.rb' file responsible for establishing the connection to the database - creating the database if it does not exist.

```sql
  require 'sqlite3'
  require_relative '../lib/song.rb'

  DB = {:conn => SQLite3::Database.new('../db/music.db')}
```

We set up a constant, 'DB', to reference a hash that contains the connection to the database. The 'lib/song.rb' file is our Song class, it can access the database connection via 'DB[:conn]'. You can access the database throughout the app using 'DB[:conn]. To map a class to a table, create a table whose name is a pluralized version of the class name, and the table column names match the attr_accessor of the class.


```sql
  class Song
    attr_accessor :name, :album, :id

    def initialize(name, album, id = nil)
      @id = id
      @name = name
      @album = album
    end

    def self.create_table
      sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS songs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          album TEXT
        )
        SQL
      DB[:conn].execute(sql)
    end
  end
```

### Saving Instances/Ruby objects to the Database

When saving class instances, we're not actually saving the actual ruby object but the values of the objects instance attributes. A new row is created in the table, and each attributes value saved to the corresponding column field.

```sql
  INSERT INTO songs (name, album) VALUES ('song name', 'album name');
```

We can abstract this functionality into an instance method, e.g.

```sql
  def save
    sql <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.name)
  end
```

We're using bound parameters to protect our database from SQl injection attacks by malicious users. Instead of interpolating variables into SQL, we use ? as placeholders and rely on #execute method to substitute in the values we pass in as arguments. We didn't insert an id. That's automatically inserted during the insert operation. Creating the object instance and saving it to the database are two separate processes. We can save the record at the same time as it's creation. Generally, we don't want to be saving records every time we create them, thus coupling the two processes, since we may want to at times create instances and not save them. Thus to create and save a song:

```sql
  Song.create_table
  song = Song.new('99 Problems', 'The Black Album')
  song.save
```

When a song is inserted into the table, we create a new row which is given a new id automatically. In order to update the instance's id attribute we can grab the record's id value when the record is created:

```sql
  def save
    sql = <<- SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.album)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

  end
```

The process of creating and then saving an instance can can be abstracted further into a single method:

```sql
  def self.create(name:, album:)
    song = Song.new(name, album)
    song.save
    song
  end
```

We use keyword arguments to pass the name and album to #create, with the method returning an instance of the new object( saves having to run a database query to fetch the newly created record from the database).


### Updating a Record

To update a record, first retrieve it, update the object instance before saving it to the database, e.g.

```sql
  song = Song.find_by_name('99 Problems')
  song.album = 'The Black Album'

  sql = "UPDATE songs SET album = ? WHERE name = ?"
  DB[:conn].execute(sql, song.album, song.name)
```

To update another song attribute we would need a different sql statement, e.g.

```sql
  song = Song.find_by_name('99 Problems')

  sql = "UPDATE songs SET name = ? WHERE name = ?"
  DB[:conn].execute(sql, 'Encore', song.name)
```

This particular pattern results in a lot of duplication of code. A simpler technique is simply to update all the records attributes, using the instances id to identify it in the database, .e.g.

```sql
  def update
    sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.album, self.id)
  end
```

Result, retrieve the song as before, update the parameter ans call #update to update the corresponding database record, e.g.

```sql
  song = Song.find_by_name('99 Problems')
  song.name = 'Encore'
  song.update
```

### Refactor #save method

The current #save method will always insert a new row into the table, resulting in duplicate records if that record already exists (the only difference being the record id). We need to check if that record already exists first, if so simply call #update otherwise insert the instance. This can be simply done by checking if the instance has an id of 'nil', i.e. it's not been saved(inserted into the database).

The updated #save method:

```sql
  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO songs (name, album)
        VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.album)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    end
  end
```


### Prevent Record Duplication

Before creating a new record and saving it to the database, we need to check that it does not already exist, e.g. in the case of the song class we'd query the database for a record with matching attributes.

```sql
  SELECT * FROM songs WHERE name = '99 Problems' AND album = 'The Black Album';
```

The #find_or_create_by method either creates and saves an instance of the song if no matching record is found in the database, otherwise it simply returns an instance of the song, without saving the song so preventing duplicate records being created in the database.

```sql

  def.find_or_create_by(name:, album:)
    sql = <<-SQL
      SELECT * FROM songs
      WHERE name = ? AND album = ?
    SQL
    array = DB[:conn].execute(sql, name, album)
    -- query returns an array, nil/empty array if no matching record found
    if array.empty?
      -- the record does not exist create, save and return an instance
      song = Song.create(name: name, album: album)
    else
      -- the record exists, return an instance
      data = array.first
      song = self.new(song[1], song[2], song[0])
    end
    song
  end
```







The complete Class:

```sql
  class Song
    attr_accessor :name, :album
    attr_reader = :id

    def initialize(name, album, id = nil)
      @id = id
      @name = name
      @album = album
    end

    def self.create_table
      sql =  <<-SQL
        CREATE TABLE IF NOT EXISTS songs (
          id INTEGER PRIMARY KEY,
          name TEXT,
          album TEXT
        )
        SQL
      DB[:conn].execute(sql)
    end

    def self.create(name:, album:)
      song = Song.new(name, album)
      song.save
      song
    end

    def self.new_from_db(row)
      self.new(row[1], row[2], row[0])
    end

    # returns an array of song instances
    def self.all
      DB[:conn].execute("SELECT * FROM songs;").map do |row|
        self.new_from_db(row)
      end
    end

    def self.find_by_id(id)
      sql = <<-SQL
        SELECT * FROM songs
        WHERE id = ?
      SQL
      DB[:conn].execute(sql, id).map {|row| self.new_from_db(row)}.first
    end

    def self.find_by_name(name)
      sql = <<-SQL
        SELECT * FROM songs
        WHERE name = ?
        LIMIT 1
      SQL

      DB[:conn].execute(sql, name).map do |row|
        self.new_from_db(row)
      end.first
    end

    def save
      if self.id
        self.update
      else
      sql = <<-SQL
        INSERT INTO songs (name, album)
        VALUES (?, ?);
      SQL

      DB[:conn].execute(sql, self.name, self.album)
      -- request the last inserted row's id, returns [[id]]
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
      end
    end

    def update
      sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
      DB[:conn].execute(sql, self.name, self.album, self.id)
    end

  end
```
