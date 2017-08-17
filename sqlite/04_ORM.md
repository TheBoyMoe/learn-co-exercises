## ORM

Object Relational Mapping (ORM) is simply a technique of 'mapping' ruby classes and instances to SQL tables and rows respectively. Classes are equated with tables and instances with rows. It's a design pattern. Thus ensuring that code is better organised and avoids code duplication. Thus a Cat class is mapped to a cats (plural) table. Each cat instance is stored as a row, the individual property values mapping to column values.

A simple class that saves instances of the 'Cat' class might look like this:

```ruby
class Cat

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
