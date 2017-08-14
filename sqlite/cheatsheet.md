# SQL Commands


## sqlite prompt commands

```text
  .help                   list SQL Commands
  .tables                 list all tables in that particular database
  .schema                 display the structure of each table (reflects the current structure of the table, which is reflected as the CREATE statement necessary to re-create that table, problematic in SQLite - best to delete and re-create the table).
  .header on              output the name of each column
  .mode column            now we are in column mode, enabling us to run the next two .width commands
  .width auto             adjusts and normalizes column width
  .width NUM1, NUM2       customize column width
```

## SQLite Keywords

```text
  CREATE TABLE            create a new table with columns, including 'id'              
  ALTER TABLE             add a column to a table (sqlite does not support deleting columns)
  DROP TABLE              delete a table
  INSERT INTO             insert a row into a database table
  SELECT                  select data from a database table
  WHERE                   'where clause' select data from a specific row
  UPDATE                  update data within a table row
  DELETE                  delete data from a table row
  ORDER BY                query modifier, order the table rows returned
  DESC|ASC                query modifier, display the rows returned in either ascending or descending order
  LIMIT                   query modifier, determine the number of rows returned
  BETWEEN                 query modifier, limit the results returned between certain values
  NULL                    used for column fields with no value
  COUNT                   aggregate function,
  GROUP BY                aggregate function,

```
