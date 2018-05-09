# Association Methods in Javascript

## Objectives
+ Understand how to use associate objects with a store.
+ Understand how to use JavaScript methods to find associated objects.

### Associating Objects

So far we have seen how to construct different types of objects in JavaScript with the class syntax.  

```js
  class User {
    constructor(name){
      this.name = name
    }
  }

  new User('bob')
```

Now let's say all of our users have many items they purchased.  We can represent the items in the following way.

```js
  class Item {
    constructor(name, price){
      this.name = name
      this.price = price
    }
  }

  new Item(400)
```

If we have a user, with multiple items we would want a way to associate items with a particular user.  To do so, first determine how an item is associated with a user.  There are two types of relationships for us to choose from:

1. Many to Many - that is, a item has many users, and a user has many items
2. HasMany and BelongsTo - that is, a user has many items and a item belongs to a user.

Because a item can only be associated with one user (we are assuming that each item can only be owned by one user), we say that a item belongsTo a user and a user has many items.  This is very similar to our concept of associating data with sql.  If you are unfamiliar with how to associate data in sql, you can check it out [here](https://github.com/learn-co-curriculum/sql-table-relations-readme).

So you could imagine representing the information in the following way:

```js
  [{itemName: 'red socks', userName: 'Cindy'},
  {itemName: 'blue shirt', userName: 'Cindy'},
  {itemName: 'blue trousers', userName: 'Bob'},
  {itemName: 'black tshirt', userName: 'Bob'},

]
```

However, there is the potential that two users may have the same name, so name is probably not the best way to identify a particular user.  Instead, we should probably associate them by giving each user an id, and each item an id.   

```js
  let store = {items: [
    {id: 1, price: 2, name: 'red socks', userId: 1},
    {id: 2, price: 7, name: 'blue shirt', userId: 1},
    {id: 3, price: 4, name: 'black tshirt', userId: 2}
    ],
  users: [
    {id: 1, name: 'Cindy'},
    {id: 2, name: 'Billy'},
    {id: 3, name: 'Bobby'}
  ]}
```

Let's try to see what's going on in the data structure above.  We assign a variable called `store` to a JavaScript object.  The `store` object will represent all of the objects that are initialized, and we will use it to store these objects.  The `store` object has two keys each of which points to an array: one to represent the collection of items and one to represent the collection of users.  

Let's see if we can answer some questions with our data structured like this.  For example, if we want to see the name of the user that is associated with our first item, just take a look at the `userId` which is 1, and then go find the user with id 1, and see that the name is Cindy.  We can also go find all of the items associated with Cindy.  To do so, we see that its id is 1, and then find all of the items with a `userId` of 1: the first and second items.  

So this is the structure we are aiming for.  How do we hook this up to our classes?

### Linking Instances to a Store

1. Assign an id each time we make a new instance

We need to assign each item object an id, and that id should increment each time we make a new item.  I bet if you close your eyes and rub your forehead with your index finger, you can think of the solution yourself.


```javascript
  let itemId = 0
  class Item {
    constructor(price, name){
      this.id = ++itemId
      // increment itemId, then assign the itemId as the instance's id
      this.name = name
      this.price = price
    }
  }

  let item = new Item(24, 'trousers')
  // {id: 1, name: 'trousers', price: 24}
  let secondItem = new Item(8, 't-shirt')
  // {id: 2, name: 'tshirt', price: 8}
```

We set the `itemId` outside of the `Item` class so we can initialize the `itemId` to zero only one time, and then increment every time an item is initialized.  Notice that we use `++itemId` to increment the `itemId` and then assign it to the new item's id.`++itemId` is used instead of `itemId++` because if you put the `++` before the variable name this will return the value _after_ incrementing.

2. Our second task is to insert these new objects to the `store`

```javascript
let store = {items: []}
// initialize store with key of items that points to an empty array

let itemId = 0

class Item {
  constructor(price, name){
    this.id = ++itemId
    this.name = name
    this.price = price

    // insert in the item to the store
    store.items.push(this)
  }
}

let item = new Item(24, 'trousers')
let secondItem = new Item(8, 't-shirt')

store.items[0]
// {id: 1, name: 'trousers', price: 24}
```
Ok, let's do the same thing with users.

```javascript
let store = {items: [], users: []}
// initialize store with key of items and users that each point to an empty array

let userId = 0

class User {
  constructor(name){
    this.id = ++userId
    this.name = name

    // insert in the user to the store
    store.users.push(this)
  }
}
```

Finally, let's allow the ability to associate a user with a item.

```js
let itemId = 0

class Item {
  constructor(price, name, user){
    this.id = ++itemId
    this.name = name
    this.price = price
    if(user){
      this.userId = user.id
    }

    // insert in the item to the store
    store.items.push(this)
  }
  setUser(user){
    this.userId = user.id
  }
}

let bobby = new User("bobby")
let trousers = new Item(24, 'trousers', bobby)

store
// {users: [{id: 1, name: 'Bobby'}], items: [{id: 1, name: 'trousers', price: 24, userId: 1}]}
```

So from the code above, you can see that we can associate a item with a user either by passing through a item to a user upon initialization or by by calling a the `setUser` setter method that we wrote.  

## Summary

In this lesson, we saw how we can use a plain javascript object to store and associate our data.  We showed how we can assign each new instance an id by modifying our `constructor` method.  We also saw that we can write setters or modify our constructor methods to provide an interface to associate a two objects.     

## Resources

+ [Sql Relations](https://github.com/learn-co-curriculum/sql-table-relations-readme)

