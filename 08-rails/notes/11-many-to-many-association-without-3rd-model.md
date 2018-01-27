## Many-to-many active record association without 3rd model

Defin the two models

```ruby
	class Passenger < ActiveRecord::Base
  	has_and_belongs_to_many :taxis
  end
	
	class Taxi < ActiveRecord::Base
  	has_and_belongs_to_many :passengers
  end

```


Create the join table
	- must start with 'create'
	- must be in alphabetical order, e.g passengers, must come before taxis and be pluralized => 'create_passengers_taxis'
	- models mus be singular
	- rails will look for 'taxi_id' and 'passenger_id' in 'passengers_taxis' table
	
	  
```txt
	bundle exec rails g migration create_passengers_taxis taxi:references passenger:references
```

The migrations

```ruby
	class CreateTaxis < ActiveRecord::Migration
    def change
      create_table :taxis do |t|
        t.timestamps null: false
      end
    end
  end

	class CreatePassengers < ActiveRecord::Migration
    def change
      create_table :passengers do |t|
        t.timestamps null: false
      end
    end
  end

	class CreatePassengersTaxis < ActiveRecord::Migration
    def change
      create_table :passengers_taxis do |t|
        t.references :taxi, index: true, foreign_key: true
        t.references :passenger, index: true, foreign_key: true
      end
    end
  end
```

Run the migrations generating the following schema

```ruby
	ActiveRecord::Schema.define(version: 20180127140413) do
  
    create_table "passengers", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "passengers_taxis", force: :cascade do |t|
      t.integer "taxi_id"
      t.integer "passenger_id"
    end
  
    add_index "passengers_taxis", ["passenger_id"], name: "index_passengers_taxis_on_passenger_id"
    add_index "passengers_taxis", ["taxi_id"], name: "index_passengers_taxis_on_taxi_id"
  
    create_table "taxis", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
  end
```


Test - from rails console

```ruby
	taxi = Taxi.create
	#=> #<Taxi id: 1, created_at: "2018-01-27 14:19:33", updated_at: "2018-01-27 14:19:33">
  
  passenger = Passenger.create
	#=> #<Passenger id: 1, created_at: "2018-01-27 14:19:50", updated_at: "2018-01-27 14:19:50"> 

	# associate passenger with taxi
	taxi.passengers << passenger 
	
	# reciprocal relationship is also created
  passenger.taxis
 	#=> #<ActiveRecord::Associations::CollectionProxy [#<Taxi id: 1, created_at: "2018-01-27 14:19:33", updated_at: "2018-01-27 14:19:33">]>
  taxi.passengers
  #=> #<ActiveRecord::Associations::CollectionProxy [#<Passenger id: 1, created_at: "2018-01-27 14:19:50", updated_at: "2018-01-27 14:19:50">]>  
```
