# SQL Commands


## Commands

```markdown
  .help                   list SQL Commands
  .tables                 list all tables in that particular database
  .schema                 display the structure of each table (reflects the current structure of the table, which is reflected as the CREATE statement necessary to re-create that table, problematic in SQLite - best to delte and re-create the table).

```

## Keywords

```markdown
  CREATE TABLE            create a new table with columns, including 'id'              
  ALTER TABLE             add a column to a table
  DROP TABLE              delete a table
```

## Examples

```markdown
sqlite> CREATE TABLE cats (
      id INTEGER PRIMARY KEY,
              name TEXT,
              age INTEGER
          );

sqlite> ALTER TABLE cats ADD COLUMN breed TEXT;
```
