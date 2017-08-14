# SQL Basics

## References

1. [SQLite Documentation](http://www.sqlite.org/docs.html)
2. [SQLite tutorial](http://zetcode.com/db/sqlite/)
3. [SQLite Keywords](https://www.sqlite.org/lang_keywords.html)
4. [SQLite Datatypes](https://sqlite.org/datatype3.html)

## Basics

* Use lower case and snake_case(link multiple words with underscores) for column names
* SQLite is NOT case sensitive with it's commands, although convention is to capitalize them.
* Before being able to store any data in the database, you need to define the columns and their specific data type.
* Primary key - unique and auto-incrementing, starting at 1.
* When creating a table, need to provide a name and at least the name of one column.
* Each column has a name and a data type. A datatype not only informs as to the type of data type that can be stored in that column, but also restricts it.
* Sqlite has 4 basic datatypes:
  * TEXT - any alphanumeric characters which we want to represent as plain text.
  * INTEGER - whole number. If you want to perform math, create a comparison between two different rows, then store the value as an integer.
  * REAL - float/decimal number, upto 15 characters long
  * BLOB - used to store binary data, typically images, or other media types( sometimes executables?).

  NOTE 1: SQLite does not have a separate boolean datatype, bools are stored as integers, 0(false) and 1(true).

  NOTE 2: SQLite does not have a separate Date/Time datatype. Use TEXT, INTEGER or REAL datatypes.

  NOTE 3:  You can use INT as the datatype to accommodate other SQL databases


## Creating a database and table

Create a database:

```sql
sqlite> CREATE TABLE cats (
      id INTEGER PRIMARY KEY,
              name TEXT,
              age INTEGER
          );

sqlite> ALTER TABLE cats ADD COLUMN breed TEXT;
```

To create a table from a file, enter the 'CREATE TABLE' command above into a file with the .sql extension. After creating the database, execute the file as below. Note: make sure you exit the sqlite prompt between commands.


```sql
  sqlite3 pets_database.db
```

Create a table:

```sql
  sqlite3 pets_database.db < create_cats_table.sql
```


## Inserting, updating, deleting and selecting records

1. Insert into

```sql
  INSERT INTO cats (name, age, breed) VALUES ('Maru', 3, 'Scottish Fold');
```

Following the 'INSERT INTO' keyword is the table name, the first parenthesis are the column headings, the second are the values.
  * the column names can be in any order, order of the values must match
  * you don't have to specify every column, the field is left empty for that particular column.
  * an error is thrown if you specify a column which has not been defined.
  * each record is automatically given an id field as long as you specified an 'id' column in the 'CREATE TABLE' statement that was 'INTEGER PRIMARY KEY' - auto increments when a record is added.
  * you can run the command from within a file or from the sqlite prompt

2. Select from

General form:

```sql
  SELECT [names of columns we are going to select] FROM [table we are selecting from];
```

```sql
  SELECT * FROM cats;
```  
Where * (wildcard selector) selects all columns from table 'cats'. We can pass the name of the columns explicitly to return only those, e.g

```sql
  SELECT id, name, age FROM cats;
```

Only the values for the columns specified are returned.

Where you have columns with duplicate values/fields, specify a query that only returns unique values, e.g.

```sql
  SELECT DISTINCT name FROM cats;
```

Using the 'WHERE' Clause: when you want to select the row(s) that match a particular condition, e.g. breed = 'Tom Cat'. You can use comparison operators, such as > or <.

General form:

```sql
  SELECT * FROM [table name] WHERE [column name] = [some value];
```
```sql
  SELECT * FROM cats WHERE age > 4;
```

3. Updating records

General form:

```sql
  UPDATE [table name] SET [column name] = [new value] WHERE [column name] = [value];
```

Example:

```sql
  UPDATE cats SET name = 'Max' WHERE name = 'Sylvester';
```

4. Deleting records

General form:

```sql
  DELETE FROM [table name] WHERE [column name] = [value];
```

Example:

```sql
  DELETE FROM cats WHERE id = 4;
```
