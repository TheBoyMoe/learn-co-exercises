## Dynamic ORMs

If we were to create multiple Ruby classes that were mapped to SQL databases, a lot of the code from class to class would be duplicate. A dynamic ORM is when where this duplicate code is abstracted out, allowing the ORM to be applied to multiple classes. Such a class contains the 'attr_accessors' of a Ruby class, but the insert, delete, select and update methods are shared.

1. Define the database, DB connection and table in config/environment.rb file. One change is to use the #results_as_hash method. Ordinarily 'SELECT' queries return a database row as an array, e.g.

```sql
  [[1, '99 Problems', 'The Black Album']]
```

Instead it will return a hash, with the column names as keys, .e.g.

```sql
  {'id' => 1, 'name' => '99 Problems', 'album' => 'The Black Album', 0 => 1, 1 => '99 Problems', 2 => 'the Black Album'}
```

2. Next we'll dynamically create the 'attr_accessors' for the Song class from the column names of the table. To do so we need a method that allows the class to query the songs table, .table_name. The table name, 'songs' is not referred to explicitly. Instead, we reference the class name through 'self' keyword, which is converted to a string, downcased and pluralized. Means the method can be shared.

3. To query the column names, we use the following SQL query, 'PRAGMA table_info(<table name>)', which returns an array of hashes, each hash representing a column. Each hash has a name attribute whose value is the column name:

```sql
[
  {"cid"=>0,"name"=>"id","type"=>"INTEGER","notnull"=>0,"dflt_value"=>nil,"pk"=>1,0=>0,1=>"id",2=>"INTEGER",3=>0,4=>nil,5=>1},
  {"cid"=>1,"name"=>"name","type"=>"TEXT","notnull"=>0,"dflt_value"=>nil,"pk"=>0,0=>1,1=>"name",2=>"TEXT",3=>0,4=>nil,5=>0},
  {"cid"=>2,"name"=>"album","type"=>"TEXT","notnull"=>0,"dflt_value"=>nil,"pk"=>0,0=>2,1=>"album",2=>"TEXT",3=>0,4=>nil,5=>0}]
```

```sql
  def self.column_names
    DB[:conn].results_as_hash = true
    sql = "PRAGMA table_info('#{table_name}')"

    table_info = DB[:conn].execute(sql)
    column_names = []

    -- iterate over hash array, capturing each column name in turn
    table_info.each do |column|
      column_names << column["name"]
    end

    -- compact removes any nil values, the result is ['id', 'name', 'album']
    column_names.compact
  end
```

4. We can now generate the the 'attr_accessors' by iterating over the column_names array and converting each string column name into a symbol with the #to_sym method

```sql
  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end
```

5. Next we'll create an #initialize method that will accept named, or keyword, arguments without explicitly naming them, .e.g.

```sql
  def initialize(options={})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end
```

The result is that #new is called with a a hash, which defaults to empty. We iterate over the hash, using the #send method to interpolate the name of each key as the attribute name and it;s value as the attribute value. This method works as long as each property has a corresponding attr_accessor.

6. To get the table name(not forgetting that self in an instance method refers to the instance and not the class), use the following method.

```sql
  def table_name_for_insert
    self.class.table_name
  end
```

7. All we now need to do is grab the column names in an abstract manner. We already have a method to retrieve column names, self.column_names. To call it from within an instance method use self.class.column_names. Since the id is generated when the record is added to the database, we need to remove the id from the array of column_names.

```sql
  def col_names_for_insert
    self.class.column_names.delete_if {|col| col == "id"}.join(", ")
  end
```

8. To abstract out the values for insert we can use the following method

```sql
  def values_for_insert
    values = []
    self.class.column_names.each do |col_name|
      values << "'#{send(col_name)}'" unless send(col_name).nil?
    end
    values.join(", ")
  end
```

9. We can now build the #save method using the methods created in steps 6 - 8.

```sql
  def save
    sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert}) VALUES (#{values_for_insert})"

    DB[:conn].execute(sql)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
  end
```

10. We can also build an abstract .find_by_name method

```sql
  def self.find_by_name(name)
    sql = "SELECT * FROM #{self.table_name} WHERE name = #{name}"
    DB[:conn].execute(sql)
  end
```

Check song.rb in the 06-dynamic-orm/lib folder for the complete class.


### Dynamic ORMs and Inheritance

Creating an abstract ORM in this manner allows us to use it with multiple classes that can inherit from it since none of the methods are specific to any one class. The only code that any sub-class need to contain is to call the self.column_names method and iterate over the resulting array so as to create the attr_accessor methods, e.g.

```sql
  class Song < InteractiveRecord

    self.column_names.each do |col_name|
      attr_accessor col_name.to_sym
    end

  end
```

The majority of the code lives in the super class since it's not specific to any one class. Any class requiring access to those methods can simply inherit them.

### References

1. [Dynamic ORMs](https://github.com/theBoyMo/dynamic-orms-readme-cb-000)
2. [Dynamic ORMs and Inheritance](https://github.com/learn-co-students/dynamic-orm-inheritance-cb-000)
