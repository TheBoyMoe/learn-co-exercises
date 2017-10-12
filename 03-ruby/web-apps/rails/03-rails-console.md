### Rails Console

The Rails console is the IRB with a full rails environment, including your model classes. Means you can carryout all the CRUD operations on your model data, and do it on multiple records at once.

To launch the Rails console, type in your terminal:

```text
    bin/rails console
````

#### Reading 

We can retieve all our model objects using the all method, Post being the model class in this example:

```text
    Post.all
```

This executes the 'SELECT "posts".* FROM "posts"' sql command.

We can fetch the most recent "Post" by calling the "last" method on the "Post" class e.g type 'Post.last'. This generates the sql command

```text
    SELECT "posts".* FROM "posts" ORDER BY "posts"."id" DESC LIMIT ? [["LIMIT", 1]]
```