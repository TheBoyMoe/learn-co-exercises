## Active Record Associations

An association is a connection between two active record models. there a six types:

1. belongs_to 
	- sets up a one-to-one with another model, such that the `belongs_to` model can be associated with only one other instance.
	- `belongs_to` associations must use the singular of the other model
	- you must add a reference to the other model's id to this model's table - foreign key
	
2. has_many
	- indicates a one-to-many relationship, often used as the reciprocal relationship of a `belongs-to` association
	
3. has_many :through
	- indicates a many-to-many relationship, the asociation being made indirectly through a 'join' model. The association indicates that a model can have zero or more instances of another model by proceeding through a third model.
	
	
```ruby
	# the models
	class Physician < ApplicationRecord
    has_many :appointments
    has_many :patients, through: :appointments
  end
   
  class Appointment < ApplicationRecord
    belongs_to :physician
    belongs_to :patient
  end
   
  class Patient < ApplicationRecord
    has_many :appointments
    has_many :physicians, through: :appointments
  end
  
  
  # migrations
 	class CreateAppointments < ActiveRecord::Migration[5.0]
    def change
      create_table :physicians do |t|
        t.string :name
        t.timestamps
      end
   
      create_table :patients do |t|
        t.string :name
        t.timestamps
      end
   
      create_table :appointments do |t|
        t.belongs_to :physician, index: true
        t.belongs_to :patient, index: true
        t.datetime :appointment_date
        t.timestamps
      end
    end
  end 
```


The has_many :through association is also useful for setting up "shortcuts" through nested has_many associations, e.g, if a document has many sections, and a section has many paragraphs.


```ruby
	class Document < ApplicationRecord
    has_many :sections
    has_many :paragraphs, through: :sections
  end
   
  class Section < ApplicationRecord
    belongs_to :document
    has_many :paragraphs
  end
   
  class Paragraph < ApplicationRecord
    belongs_to :section
  end
```

With through: :sections specified, you may get a collection of all paragraphs in the document


```ruby
	@document.paragraphs
```

4. has_one and has_one :through
	- sets up a one-to-one connection with another model, one model can be matched directly with one model (often used in combination with belongs_to for the other association) or through a third model, i.e. has_one :through. For example, each Supplier is associated with one account, and each account is associated with one account history throgh that account.
	
	
```ruby
	# classes
	class Supplier < ApplicationRecord
		has_one :account
		has_one :account_history, through: :account
	end
	 
	class Account < ApplicationRecord
		belongs_to :supplier
		has_one :account_history
	end
	 
	class AccountHistory < ApplicationRecord
		belongs_to :account
	end
	
	# migrations
	class CreateAccountHistories < ActiveRecord::Migration[5.0]
		def change
			create_table :suppliers do |t|
				t.string :name
				t.timestamps
			end
	 
			create_table :accounts do |t|
				t.belongs_to :supplier, index: true
				t.string :account_number
				t.timestamps
			end
	 
			create_table :account_histories do |t|
				t.belongs_to :account, index: true
				t.integer :credit_rating
				t.timestamps
			end
		end
	end 
```

5. has_and_belongs_to_many
	- creates a direct many-to-many connection with another model with no intervening model. For example, if your application includes assemblies and parts, with each assembly having many parts and each part appearing in many assemblies, e.g.
	
```ruby
	# classes	
	class Assembly < ApplicationRecord
		has_and_belongs_to_many :parts
	end
	 
	class Part < ApplicationRecord
		has_and_belongs_to_many :assemblies
	end
	
	#migrations
	class CreateAssembliesAndParts < ActiveRecord::Migration[5.0]
		def change
			create_table :assemblies do |t|
				t.string :name
				t.timestamps
			end
	 
			create_table :parts do |t|
				t.string :part_number
				t.timestamps
			end
	 
			create_table :assemblies_parts, id: false do |t|
				t.belongs_to :assembly, index: true
				t.belongs_to :part, index: true
			end
		end
	end 
```

Although there is no third model, you'll still need to create a joining table in the database.
 
You should set up a has_many :through relationship if you need to work with the relationship model as an independent entity, e,g, you need validations, callbacks or extra attributes on the join model. If you don't need to do anything with the relationship model, it may be simpler to set up a has_and_belongs_to_many relationship.