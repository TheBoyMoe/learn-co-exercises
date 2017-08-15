## SQL Table Relations

We create relationships between tables through the use of a foreign key column. It uses the primary key of a record in one table to refer to that record in another table.   The foreign key column has a datatype of integer.

When deciding which table to add the foreign key column, think about the relationship that exists. When an object 'has many' relationship to another object it is seen as the parent. The foreign key (primary key of the parent) is thus added to the 'child'.

SQL join clauses/statements are a means of combining the data from multiple tables based on the common column between them. There a re several types of join:
  * inner join - returns all rows from both tables when a condition is met.
  * left join - returns all rows from the left table, and the matched rows from the right table
  * right join - returns all rows from the right table, and the matched rows from the left table
  * full join - returns all rows when there is a match in ONE of the tables

### Inner join

General form:

```sql
  SELECT [column_name(s)]
  FROM [first_table]
  INNER JOIN [second_table]
  ON [first_table.column_name] = [second_table.column_name];
```

Example:

```sql
  SELECT Cats.name, Cats.breed, Owners.name AS "Owner's name"
  FROM Cats
  INNER JOIN Owners
  ON Cats.owner_id = Owners.id;
```

The 1st line determines the columns from each we want returned.
The 2nd and 3rd lines create the inner join.
Lastly we set the condition, how to connect(or join) the two tables - which columns in each table function as the foreign/primary key connection.

The join will return all cats which have a value in the owner_id column that matches a value in the owners.id column. Any cat without an owner_id value, e.g NULL, or where the owner_id value that does not match th id of an existing owner will not be returned.


### Left Outer join

Returns all rows from the first(left) table regardless of whether they meet the condition, together with the rows from the second(right) table that meet  the condition. Data from the first table that does not meet the condition set will display NULL(empty) values for the field of the condition (whether or not that column field has an actual value). Thus any row without a value for that particular column field you know did not match the condition.

General form:

```sql
  SELECT [column_name(s)]
  FROM [first_table]
  LEFT JOIN [second_table]
  ON [first_table.column_name] = [second_table.column_name];
```

Example:

```sql
  SELECT Cats.name, Cats.breed, Owners.name
  FROM Cats
  LEFT OUTER JOIN Owners
  ON Cats.owner_id = Owners.id;
```
