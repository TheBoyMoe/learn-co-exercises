## Querying Active Record

Active Record provides a number of methods for retrieving one or more records from the database.

```ruby
  User.take #=> retrieves a row from the database, returns nil otherwise

  # equivalent => 'SELECT * FROM users LIMIT 1'

  User.take(4) #=> returns an array with that number of records

  # equivalent => 'SELECT * FROM users LIMIT 4'

  User.first #=> retrieves the first row in the database (ordered by id), returns nil otherwise

  # equivalent 'SELECT * FROM clients ORDER BY clients.id ASC LIMIT 1'

  User.first(4)  #=> returns an array with that number of records

  # equivalent 'SELECT * FROM clients ORDER BY clients.id ASC LIMIT 4'

  User.order(:name).first #=> return 1st record ordered by specified attribute

  # equivalent 'SELECT * FROM clients ORDER BY clients.first_name ASC LIMIT 1'

  User.last #=> retrieves the last row in the database (ordered by id), returns nil otherwise

  # equivalent 'SELECT * FROM clients ORDER BY clients.id DESC LIMIT 1'

  User.where('subject = ?, location = ?', arg1, arg2) # arguments replace the question marks in the order given
  User.where(subject: 'biology', location: 'London') # you can pass in hash key/value pairs

  # equivalent 'SELECT * FROM users WHERE subject = ? AND location = ?'  

  User.where.not(subject: 'biology')

  # you can retrieve records in a specific order
  User.order(:created_at)
  User.order('created_at')

  User.order(created_at: :desc)
  User.order('created_at DESC')

  User.order(orders_count: :asc, created_at: :desc)
  User.order("orders_count ASC", "created_at DESC")

  User.where('id > 10').limit(20).order('id asc')
```

#### Retrieving Multiple Records

Where your dataset is less than 1000 records, use the #each method, .e.g.

```ruby
  User.all.each do |user|
    NewsMailer.weekly(user).deliver_now
  end
```

As the table size increases, this technique becomes impracticle due to the hit on performance. User.all.each instructs ActiveRecord to fetch the entire table in a single pass, build a model object per row, and then keep the entire array of model objects in memory. ActiveRecord provides 2 methods to overcome this limitation:

1. find_each - retrieves records in batches of 1000, then yields them one at a time into the block. More batches are fetched as needed, until all records have been processed.

```ruby
  User.find_each do |user|
    NewsMailer.weekly(user).deliver_now
  end

  # do NOT employ ordering
  User.where(weekly_subscriber: true).find_each do |user|
    NewsMailer.weekly(user).deliver_now
  end
```

You can employ a number of options

```ruby

# retrieve batches of 5000
User.find_each(batch_size: 5000) do |user|
  NewsMailer.weekly(user).deliver_now
end

# ordinarily records are returned in ascending order from the lowest id, use 'start:' to set the start id. You can also use 'finish:' to set the last id.
User.find_each(start: 2000) do |user|
  NewsMailer.weekly(user).deliver_now
end

# use 'start:' and 'finish:' to process a subset
User.find_each(start: 2000, finish: 10000) do |user|
  NewsMailer.weekly(user).deliver_now
end
```

#### Calculations

The following methods are available: count, average, minimum, maximum and sum. You can use these in combination with where, include, etc.

```ruby
  User.count
  User.where(subject: 'Biology').count
  User.includes('orders').where(status: 'received').count
  User.sum('orders_count')
  User.average('age')
  User.minimum('age')
  User.maximum('age')
```
