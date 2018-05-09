# Association Methods in Javascript

## Objectives
+ Learn how to build methods to select associated objects.
+ Learn how to build methods to find objects by certain attributes.

### Associating Objects
In the previous lesson we saw how to associate objects through use of a store and adding functionality to our JavaScript classes.  Let's take another look at that code.

```javascript
let store = {users: [], items: []}
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

let itemId = 0

class Item {
  constructor(name, price, user){
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
let sally = new User("sally")
let trousers = new Item('trousers', 24, bobby)
let tshirt = new Item('tshirt', 8, bobby)
let socks = new Item('socks', 3, sally)

store
// {users: [{id: 1, name: 'Bobby'}, {id: 2, name: 'Sally'}], items: [{id: 1, name: 'trousers', price: 24, userId: 1}, {id: 2, name: 'tshirt', price: 8, userId: 1}, {id: 3, name: 'socks', price: 3, userId: 2}]}
```

Now the next thing we need to do is build some methods that would select the associated data.  For example, if we want to find all of the items associated with the first user, we would like to write a method called `items()` that would retrieve all of the items associated with the first user:

```js
  let bobby = store.users[0]  
  bobby.items()
  // we want this to return our first two items in our store, but currently this method is not implemented
```

Ok, now how would we implement a method on our user object that finds the associated items?  Well, the way we can identify the items associated with the first user is go to our store, and go through each of the items in our `store` and return the ones with a `userId` equal to 1.  We can use JavaScript's `filter` method to do just that.  Let's go for it!

```javascript
class User {
  constructor(name){
    this.id = ++userId
    this.name = name

    // insert in the user to the store
    store.users.push(this)
  }
  items(){
    return store.items.filter(item => {
      return item.userId === this.id
    })
  }
}
```

So you can see that the code above uses the `filter` method to go through the items in the `store` and return each of the items that have a `userId` equal to the id of the user receiving the items method call.  Ok, that was the hard one, now let's write a method `item.user()` such that the user associated with the item is returned.

```js

class Item {
  constructor(name, price, user){
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
  user(){
    return store.users.find(function(user){
      return user.id === this.userId
    })
  }
}

let user = new User('Freddie')
let item = new Item('socks', 3, user)
item.user()
// {id: 3, name: 'Freddie'}
```

Unlike our use of the `filter` method, JavaScript's `find` method only returns the first matching element from the array.  With our `items()` added to our user objects and the `user()` method added to our item objects  we have set up our relationship in both directions.

## Summary

In this lesson, we saw how to write methods to select our associated data.  We saw that by using JavaScript's `filter` and `find` methods we can search the `store` to return the proper JavaScript objects when our methods are called.

## Resources

+ [Sql Relations](https://github.com/learn-co-curriculum/sql-table-relations-readme)
+ [MDN Filter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
+ [MDN Find](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find)

