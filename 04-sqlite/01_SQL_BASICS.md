# SQL Basics

## References

1. [SQLite Documentation](http://www.sqlite.org/docs.html)
2. [SQLite tutorial](http://zetcode.com/db/sqlite/)
3. [SQLite Keywords](https://www.sqlite.org/lang_keywords.html)
4. [SQLite Datatypes](https://sqlite.org/datatype3.html)
5. [SQL Guide](http://www.sqlclauses.com/)
6. [Where vs Having Cluse](http://www.programmerinterview.com/index.php/database-sql/having-vs-where-clause/)
7. [SQL Joins](http://geekyisawesome.blogspot.co.uk/2011/03/sql-joins-tutorial.html)
8. [More on SQL Joins](https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)

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
  CREATE TABLE cats (
      id INTEGER PRIMARY KEY,
              name TEXT,
              age INTEGER
          );
```

To create a table from a file, enter the 'CREATE TABLE' command above into a file with the .sql extension. After creating the database, execute the file as below. Note: make sure you exit the sqlite prompt between commands.

Create a database (.db file is a binary file):

```sql
  sqlite3 pets_database.db
```

Create a table (creates database & table if it does not already exist):

```sql
  sqlite3 pets_database.db < create_cats_table.sql
```

Amend a table with the 'ALTER' command (requires SQLite3):

```sql
ALTER TABLE cats ADD COLUMN breed TEXT;
```

Add a column with a default value:

```sql
  ALTER TABLE cats ADD COLUMN value INTEGER DEFAULT 100;
```

Add a column where a value must be provided:

```sql
  ALTER TABLE cats ADD COLUMN value INTEGER NOT NULL;
```

SQLite does not support deleting or renaming columns, 'DROP' the table and re-create it. The ALTER command does support renaming the table. To drop the table:

```sql
  DROP TABLE [table_name];
```


## Inserting, updating, deleting and selecting records

1. Insert into

```sql
  INSERT INTO cats (name, age, breed) VALUES ('Maru', 3, 'Scottish Fold');
```

Following the 'INSERT INTO' keyword is the table name, the first parenthesis are the column headings, the second are the values.
  * the column names can be in any order, order of the values must match
  * you don't have to specify every column, the field is left empty for that particular column.
  * where you specify a column name, and have no value, enter NULL.
  * an error is thrown if you specify a column which has not been defined.
  * each record is automatically given an id field as long as you specified an 'id' column in the 'CREATE TABLE' statement that was 'INTEGER PRIMARY KEY' - auto increments when a record is added.
  * you can run the command from within a file or from the sqlite prompt

2. Select from

General form:

```sql
  SELECT [names of column(s), comma separated] FROM [table];
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

Select allows you to explicitly state tableName.columName you want to select. You can use this technique when you want data from two different tables, e.g.

```sql
  SELECT cats.name, dogs.name FROM cats, dogs;
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

## Basic SQL Queries

A query is an sql statement that retrieves data from the database, such as a 'SELECT' command. We include a 'WHERE' clause to limit the results returned to those matching a particular condition.

1. Order by

General form ('ORDER BY' automatically sorts the returned values in 'ASC' order). Where you two columns are specified following 'ORDER BY', sql order by the first. Where any values are the same, those values are sorted by the second column. Where one column is specified, any values that are the same are ordered by 'id' in 'ASC' order.

```sql
  SELECT [column_name(s)] FROM [table_name] ORDER BY [column_name] ASC|DESC;
  SELECT [column_name(s)] FROM [table_name] ORDER BY [column_name] ASC|DESC, [column_name] ASC|DESC;
```

Example;

```sql
  SELECT * FROM cats ORDER BY name DESC;
  SELECT name FROM cats ORDER BY name ASC;
  SELECT * FROM cats ORDER BY breed DESC;
  SELECT * FROM cats ORDER BY net_worth DESC;
```

2. Limit

To limit the number of rows returned, include the 'LIMIT' modifier, .e.g. return the 10 oldest cats in the list, the first being the oldest.

```sql
  SELECT * FROM cats ORDER BY age DESC LIMIT 10;
```

3. Between

Used in conjunction with the 'WHERE' clause, return one or more columns where a particular column value lies between a set of values.

General form:

```sql
  SELECT [column_name(s)] FROM [table_name] WHERE [column_name] BETWEEN [value1] AND [value2];
```

Example:

```sql
  SELECT name FROM cats WHERE age BETWEEN 1 AND 3;
```

4. Null

Used to specify a column field where there is no value.
Example:

```sql
  INSERT INTO cats (name, age, breed) VALUES (NULL, NULL, "Tabby");
```

SQLite treats any column with no value as NULL. If NULL was not set, SQLite will return the record following a SELECT query, e.g. SQLite returns all records from the cats table for any record that does not have value set for owner_id.

```sql
  SELECT * FROM cats WHERE owner_id IS NULL;
```

## Aggregate Functions

Are SQL statements that return the min, max, sum or average of the values of a column. We also have COUNT and GROUP BY.

1. AVG()

Returns the average value of a column

General form:

```sql
  SELECT AVG([column_name]) FROM [table_name];
```

The result returns the avg value, together with a column heading of avg([column_name]), in order to give it a more descriptive meaning, we can use the 'AS' keyword to rename the heading.

```sql
  SELECT AVG([column_name]) AS [alias_name] FROM [table_name];
```

Example:

```sql
  SELECT AVG(age) AS average_age FROM cats;
```

2. SUM()

Return the sum of all the values in a particular column.

```sql
  SELECT SUM([column_name]) FROM [table_name];
```

3. MIN() and MAX()

Return the min/max values of the specified column.

```sql
  SELECT MIN([column_name]) FROM [table_name];
```

Example - return the oldest cat

```sql
  SELECT * FROM cats ORDER BY age DESC LIMIT 1;
  SELECT name, MAX(age) FROM cats;
```

4. Count

Returns the number of records that meet a condition. Count returns the total number of rows in a table that are not null for the specified column if no 'WHERE' clause is specified.

General form:

```sql
  SELECT COUNT([column name]) FROM [table name] WHERE [column name] = [value]
```

Example:

```sql
  SELECT COUNT(age) FROM cats WHERE age > 3;
  SELECT COUNT(owner_id) FROM cats WHERE owner_id = 1;
```

To count the total number of rows/records in a database, set the column name to *

```sql
  SELECT COUNT(*) FROM cats;
```

We can also set COUNT() to * to simply count the number of rows that meet a certain criteria

```sql
  SELECT COUNT(*) FROM cats WHERE age > 4;
  SELECT COUNT(*) AS age_greater_than_4 FROM cats WHERE age > 4;
```


5. Group by

Similar to ORDER BY. Whereas ORDER BY sorts the results of basic sql queries, GROUP BY sorts the result of aggregate functions. You can also use it on multiple columns.

General form:

```sql
  SELECT [column_name(s)], AGGREGATE_FUNCTION(column_name)
  FROM [table_name]
  WHERE [column_name] operator [value]
  GROUP BY [column_name(s)];
```

Example:

```sql
  SELECT breed, COUNT(breed) FROM cats GROUP BY breed;
  SELECT breed, owner_id, COUNT(breed) FROM cats GROUP BY breed, owner_id;
  SELECT owner_id, COUNT(owner_id) AS number_of_pets FROM cats GROUP BY owner_id;
```

```sql
  SELECT SUM(cats.net_worth)
  FROM owners
  INNER JOIN cats_owners
  ON owners.id = cats_owners.owner_id
  JOIN cats ON cats_owners.cat_id = cats.id
  WHERE cats_owners.owner_id = 2;
```

### Where and Having

If you wanted to sum the bonuses received by employees, you might use a sql statement like:

```sql
  SELECT employee, SUM(bonus) FROM employees_bonus GROUP BY employee;
```

If you then wanted to refine this  to only return employees whose bonuses were greater than $1000, you might try:

```sql
  SELECT employee, SUM(bonus) FROM employees_bonus GROUP BY employee WHERE SUM(bonus) > 1000;
```

However, this will not work. the WHERE clause does not work with aggregate functions such as SUM, AVG, MIN, MAX, etc. Instead use the HAVING clause.
