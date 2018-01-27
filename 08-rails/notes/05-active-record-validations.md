## Active Record Validations

#### Validates

Validation occurs when a record is saved to the database, i.e. when '#create' or '#save' is called. Creating an instance with '#new' does not trigger validation. The only way to trigger validation without touching the database is to call the '#valid?' method.

- takes two args, 1st is the attribute(to be validated), 2nd is an options hash of 'rules' that are to be applied to the attribute. These rules are applied through 'validation helpers', e.g. `acceptence`, `presence`, `confirmation`, etc. Every ime a validation fails an error message is added to the object's error collection.

	- presence - prevents the obj being saved if the attribute is nil(or empty string if a string attr)
	- absence - checks that the value is not present, either nil or an empty string
	- acceptance - validates that a check box was clicked when a form was submitted
	- validates_associated - used with models that have associations with other models and they also need to be validated. valid? will be called on each one of the associated objects. Works with all association types.
	- confirmation - used when you have two fields that should receive exactky the same text, e.g password and email
	- exclusion/inclusion - checks that the attribute value is not/is included in a given set.
	- format - check whether an attribute value matches a given regular expression.
	- length - applied to string values(and numbers- count number of digits, e.g. phone numbers), validates that the attributes value is within the given length
	- numericality - ensures the attribute value is numeric(integer/float) - additional options allow you to be more precise
	- uniqueness - validates that the value is unique prior to being saved, useful for emails.
	
	There are a number of options that can be used in conjunction with validation helpers, e.g.
	 - :allow_nil - allow the validation to pass if the value is nil.
	 - :allow_blank - allow the validation to pass if nil or an empty string.
	 - :message - set the message that will be added to the errors collection should the validation fail.
	 - :on - specify when the validation should happen, by default on save.
	 

##### Validation Errors

'#create' and '#save' do not raise an exception when validation is failed(database update fails and false is returned), unless called with !, e.g #create! You can check that a validation would fail with '#valid?'

```ruby
	class Person < ActiveRecord::Base
    validates :name, presence: true
  end
   
  p = Person.new
  p.valid? #=> false
  p.save #=> false
  p.save! #=> EXCEPTION
```
	 
To discover the cause, check the instance's '#errors' object.

```ruby
	p = Person.new
  p.errors.messages #=> empty
  p.valid? #=> false
  p.errors.messages #=> name: can't be blank
  person.errors[:name] #=> chek a specific attribute
``` 

Display validation errors:

```html
	<% if @article.errors.any? %>
    <div id="error_explanation">
      <h2>
        <%= pluralize(@article.errors.count, "error") %>
        prohibited this article from being saved:
      </h2>
   
      <ul>
      <% @article.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>
```