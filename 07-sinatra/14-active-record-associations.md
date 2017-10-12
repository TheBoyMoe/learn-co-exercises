### ActiveRecord Associations


Using the example of dogs and owners, where a dog 'belongs_to' one owner and an owner can have many dogs.


1. Define your models, adding any req'd ActiveRecord relationships, e.g.

```ruby
  #  define the relationships between the models

  #         has_many
  #  Owner ------------>  Cats
  #         belongs_to
  #  Cat   ------------>  Owner
  #
  # add owner_id column to 'dogs' table - owner_id is the foreign key - we use the foreign key to 'store' the relationship.
  # the foreign_key always goes in the table of the model with the 'belongs_to' relationship (foreign_key are always integers)
  # when ever we use a 'has_many' relationship, we also need to use it's reciprocal, 'belongs_to', and vice-versa.

  # Owner model
  class Owner < ActiveRecord::Base
    has_many :dogs
  end

  class Dog < ActiveRecord::Base
    belongs_to :owner
  end
```


2. Create the migration classes - create the database tables based on the attributes you define for your models, e.g

```ruby
  rake db:create_migration NAME=create_dogs

  rake db:create_migration NAME=create_owners
```

The rake task will automatically create a `db` folder in the root of the project, within which it will add the `migrate` folder and migration file. The migration file starts with a timestamp, enabling the files to be run in sequence.

Within the migration file add the `up` (creates the table) and `down` (drops the table) methods.

```ruby
  # create_dogs migration class
  class CreateDogs < ActiveRecord::Migration
    def up
      create_table :dogs do |t|
        t.string :name
        t.string :breed
        t.integer :owner_id
      end
    end

    def down
      drop_table :dogs
    end
  end
```

Run `rake db:migrate` to execute the `up` method and create the table. Run `rake db:rollback` to execute the `down` method and drop the table. The `change` method incorporates both the `up` and `down` methods - having the same functionality when running `rake db:migrate` and `rake db:rollback`.


```ruby
  # create_dogs migration class
  class CreateDogs < ActiveRecord::Migration[5.1]
    def change
      create_table :dogs do |t|
        t.string :name
        t.integer :age
        t.string :breed
        t.integer :owner_id
      end
    end
  end

  # create_owners migration class
  class CreateOwners < ActiveRecord::Migration[5.1]
    def change
      create_table :owners do |t|
        t.string :name
      end
    end
  end
```

### Test the design

```ruby

tom = Owner.create(name: 'Tom Jones')
#=>  #<Owner id: 3, name: "Tom Jones">

# the 'belongs_to :owner' relationship adds the 'owner=' method, so that we can associate the cat with the owner - through the 'owner_id' column
max = Dog.new(name: 'Max', age: 4, breed: 'Mixed')
#=> #<Dog id: nil, name: "Max", age: 4, breed: "Mixed", owner_id: nil>
max.owner = tom
max.save
#=> #<Dog id: 4, name: "Max", age: 4, breed: "Mixed", owner_id: 3>


# the 'has_many :dogs' relationship allows the owner instance keep track of all it's 'children'
tom.dogs #=> [#<Dog id: 4, name: "Max", age: 4, breed: "Mixed", owner_id: 3>]
```

### Join Tables & Many-to-Many Relationships

In describing simple relationships, such as dogs and owners, 'belongs_to' and 'has_many' are sufficient. In the example of an e-commerce store, where we have User and Item classes, an item 'has_many' users, and a user 'has_many' items, we have a 'many-to-many' relationship.

Instead of adding a foreign key to each model's table, e.g. 'item_id' to the 'users' table, and vice-versa - the 'item_id' and 'user_id' are placed in a separate table - the 'join table'. Join tables, together with the `has_many :through` association, is used to implement this relationship.

A join table has only two columns, user_id and item_id in this example, to store the foreign keys. To implement a 'many-to-many' relationship:

1. we create 3 migrations, a 'users', 'items', and 'user_items'(join) tables.

```ruby
  class CreateUsers < ActiveRecord::Migration
    def change
      create_table :users do |t|
        t.string :name
        t.timestamps null: false
      end
  end

  class CreateItems < ActiveRecord::Migration
    def change
      create_table :items do |t|
        t.string :name
        t.integer :price
        t.timestamps null: false
      end
    end
  end

  class CreateUserItems < ActiveRecord::Migration
    def change
      create_table :user_items do |t|
        t.integer :user_id
        t.integer :item_id
        t.timestamps null: false
      end
    end
  end
```

2. define our models with the appropriate relationships:

```ruby
  class User < ActiveRecord::Base
    has_many :user_items
    has_many :items, through: :user_items
  end

  class Item < ActiveRecord::Base
    has_many :user_items
    has_many :users, through: :user_items
  end

  class UserItem < ActiveRecord::Base
    belongs_to :user
    belongs_to :item
  end
```

The 'User' and 'Item' classes each have a 'has_many' relationship with 'user_items' - the join table. Each also has a 'has_many' relationship with the other through the 'user_items' table.

'UserItem' class has a 'belongs_to' relationship with the other 2 classes in order to complete the relationship.

By implementing a 'many-to-many' relationship in this manner, we can use active record methods to access all the users who have purchased a particular item, as well as all the items purchased by a specific user.




### Resources

1. [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
