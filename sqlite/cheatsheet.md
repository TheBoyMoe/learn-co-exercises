# SQL Commands


## Commands

```text
  .help                   list SQL Commands
  .tables                 list all tables in that particular database
  .schema                 display the structure of each table (reflects the current structure of the table, which is reflected as the CREATE statement necessary to re-create that table, problematic in SQLite - best to delte and re-create the table).

```

## Keywords

```text
  CREATE TABLE            create a new table with columns, including 'id'              
  ALTER TABLE             add a column to a table
  DROP TABLE              delete a table
  INSERT INTO             insert a row into a database table
  SELECT                  select data from a database table
  WHERE                   'where clause' select data from a specific row
  UPDATE                  update data within a table
  DELETE                  delete data from a table
```

## Examples

```sql
sqlite> CREATE TABLE cats (
      id INTEGER PRIMARY KEY,
              name TEXT,
              age INTEGER
          );

sqlite> ALTER TABLE cats ADD COLUMN breed TEXT;
```

To create a table from a file, enter the 'CREATE TABLE' command above into a file with the .sql extension. After creating the database, execute the file as below. Note: make sure you exit the sqlite prompt between commands.

Create a database:

```sql
  sqlite3 pets_database.db
```

Create a table:

```sql
  sqlite3 pets_database.db < create_cats_table.sql
```

Insert a record into a table:

```sql
  INSERT INTO cats (name, age, breed) VALUES ('Felix', 3, 'Tom Cat');
```
