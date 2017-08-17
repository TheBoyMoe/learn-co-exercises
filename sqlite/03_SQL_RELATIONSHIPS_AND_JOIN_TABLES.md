## Relationships

There are two basic types of relationship:
  * 'has many'/'belongs to'/'one-to-many'
  * 'many-to-many'

### 'Has Many'/'Belongs To'/'One-To-Many'

In the example of the pets database, a cat has one owner, while the owner can have many cats. The cats table has a column, owner_id, that contains the foreign key corresponding to the id column of the owner's table. A cat is thus associated with the person who owns it, 'belongs to'. The owner in turn can own many cats, 'has many'/'one-to-many', any number of cats can have the same owner_id.

The 'has many'/'belongs to' relationship is created through the use of a foreign key, the owner_id column which contains the key that corresponds to the id column of the owners table. The table that contains the foreign key column is the table that contains the entities that 'belong to' another entity. The other entity that is referenced by the foreign key is the parent or owner entity that 'has many' of the other entity. This works because multiple child entities can reference the same foreign key or parent.


### 'Many-to-Many'

The 'many-to-many' relationship, e.g. where a cat has many owners and an owner can have many cats, is represented using a Join Table. Such a table would have two columns, one for each of the tables you wish to relate, a cat_id column and an owner_id column. Each row in the table represents a one-to-one relationship. Thus if a cat has 3 owners, a separate row is needed referencing the same cat_id and each owner_id in turn. The same for owners with multiple cats.

Example:

```sql
CREATE TABLE cats_owners (
  cat_id INTEGER,
  owner_id INTEGER
);
```

Basic query examples:

To return all the owners of a specific cat:

```sql
  SELECT cats_owners.owner_id
  FROM cats_owners
  WHERE cat_id = 3;
```

To return all the cats of a specific owner:

```sql
  SELECT cats_owners.cat_id
  FROM cats_owners
  WHERE owner_id = 2;
```

These simple queries simply return the id's of which cats belong to which owners and which cats have multiple owners. By using join statements with these queries, we can return the names and other properties of both entities.

Advanced queries:

General form:

```sql
SELECT [column(s)]
FROM [table_one]
INNER JOIN [table_two]
ON [table_one.column_name] = [table_two.column_name]
WHERE [table_two.column_name] = [condition];
```

Example:

Return the names of all the owners of cat with id = 3

```sql
  SELECT owners.name
  FROM owners
  INNER JOIN cats_owners
  ON owners.id = cats_owners.owner_id
  WHERE cats_owners.cat_id = 3;
```

  - the SELECT statement determines the data to return
  - FROM specifies the table to query
  - INNER JOIN we're joining the cat owners table
  - ON statement tells the query to look for id's in the owners table that match owner_id in the cat owners table
  - WHERE that particular owner has a matching cat_id of 3

Return the name(s) of all the cats owned by owner id = 2

```sql
  SELECT cats.name
  FROM cats
  INNER JOIN cats_owners
  ON cats.id = cats_owners.cat_id
  WHERE cats_owners.owner_id = 2;
```
