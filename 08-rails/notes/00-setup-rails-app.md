# Review of Project and cross-reference or relevant reference materials from the course


## Overview

This a guide to setting up a Ruby on Rails application with BDD in mind. We'll add both Cucumber and Rspec testing frameworks to accomplish this. 


## Setup and Configuration

1. Build the initial Rails app with the following command, '-T' to skip adding the Mini-test framework and '-B' so `bundle install` will not run automatically post setup. We'll do this manually.

```ruby
	rails new [app_name] -T -B
```

2. Add the following gems to the app's Gemfile(configuration steps are covered later):

```ruby
	group :development, :test do
		gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
		gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
		gem 'byebug', '~> 10.0'
  end
  
  group :test do
		gem 'cucumber-rails', require: false
		gem 'cucumber-rails-training-wheels'
		gem 'simplecov', require: false
		gem 'capybara', '~> 2.12.0'
		gem 'capybara-webkit', '~> 1.14'
		gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
		gem 'launchy', '~> 2.4', '>= 2.4.3'
		gem 'faker', '~> 1.8', '>= 1.8.7'
		gem 'shoulda-matchers', require: false
		gem 'guard', '~> 2.14', '>= 2.14.2'
		gem 'guard-rspec', require: false
		gem 'guard-cucumber', '~> 2.1', '>= 2.1.2'
  end
```


3. From the command line execute the following command from the cli.

```text
	bundle install --path vendor/bundle
```

Tells bundler to install the app's gems locally in the `vendor/bundle` directory rather than globally. Ensure that `.gitignore` has a reference to `vendor/bundle` so your not checking in the gems to your repository.


4. To install Cucumber and Rspec run the following commands:

```ruby
	bundle exec rails generate cucumber:install capybara
  bundle exec rails generate rspec:install
``` 

The `cucumber:install` and `rspec:install` commands will generate the cucumber and rspec configuration files.
(Optional) Run the following command:

```ruby
  bundle exec rails generate cucumber_rails_training_wheels:install
``` 
to generate a basic `web_steps.rb` file to get you started with Cucumber testing(recommended not be used in production apps). 

Since we're using a Rails app, load Capybara via `spec/rails_helper.rb` by adding the following line:

```ruby
	require 'capybara/rails'
```

The `cucumber-rails` gem comes with Capybara support built in, no need to integrate it with Cucumber. You can use it in your steps like so:

```ruby
	When /I sign in/ do
    within("#session") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Sign in'
  end
```

To integrate Capybara with RSpec, we'll also add the following line to `spec/rpec_helper.rb` file

```ruby
	require 'capybara/rspec'
```

Place your Capybara specs in `spec/features`, or alternately tag your spec example groups with `type: :feature`, e.g. 

```ruby
	describe "the signin process", type: :feature do
    it "signs me in" 
    it "signs me out"
  end
```

Use `js: true` tag to use the the javascript driver, selenium by default, e.g.

```ruby
	describe 'some stuff which requires js', js: true do
    it 'will use the js driver'
  end
```

To use a different javascript driver, such as webkit (requires the capybara-webkit gem), add the following line to your `spec/spec_helper.rb` file before the `RSpec.config` block:
 
```ruby
	Capybara.javascript_driver = :webkit
``` 

To use javascript in you Cucumber scenarios, tag your scenarios with the `@javascript` tag.


-- ?required ---------------------------------------------------------------------------------------- 
And add the following line to the `RSpec.config` block within `spec/spec_helper.rb`

```ruby
	config.include Capybara::DSL
```
-----------------------------------------------------------------------------------------------------


5. Create a new file called rspec.rb in features/support with the following contents:

```ruby
	require 'rspec/core'
  
  RSpec.configure do |config|
    config.mock_with :rspec do |c|
      c.syntax = [:should, :expect]
    end
    config.expect_with :rspec do |c|
      c.syntax = [:should, :expect]
    end
  end
```


6. To configure the 'shoulda-matchers' (facilitate the testing of Rails functionality such as validations and associations with less code), in `spec/rails_helper.rb` we need to `require 'shoulda/matchers'` and add the following code block at the bottom of the file.

```ruby
	Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
```

Now you can use matchers such as `validates_presence_of` to test your models.


7. In order to use Factory Bot factories in our specs, add the following line to `spec/rails_helper.rb` in the `RSpec.config` code block

```ruby
  config.include FactoryBot::Syntax::Methods
```

For Cucumber add the following line to `features/support/env.rb`

```ruby
	World(FactoryBot::Syntax::Methods)
```


8. Add the following code BEFORE ANYTHING ELSE ON LINE ONE of spec/spec_helper.rb(for RSpec) and features/support/env.rb (for Cucumber):

```ruby
	require 'simplecov'
  SimpleCov.start 'rails'
```

SimpleCov is a code coverage analysis tool. It provides overall coverage of all tests, including Cucumber features and RSpec tests, caching and merging results when generating reports. You can view coverage results by opening `coverage/index.html`. You may want to add the `coverage` folder to .gitignore.


9. We'll use the DatabaseCleaner gem to ensure that our database is in a clean state in between tests. To configure DatabaseCleaner with regards to RSpec, add the following strategy to the `RSpec.config` block in `spec/rails_helper.rb`.

```ruby
	config.use_transactional_fixtures = false
	
	config.before(:suite) do
		DatabaseCleaner.clean_with(:truncation)
	end

	config.before(:each) do
		DatabaseCleaner.strategy = :transaction
	end

	config.before(:each, :js => true) do
		DatabaseCleaner.strategy = :truncation
	end

	config.before(:each) do
		DatabaseCleaner.start
	end

	config.after(:each) do
		DatabaseCleaner.clean
	end
```

Set `config.use_transactional_fixtures` to `false`

Cucumber automatically configures the appropriate strategy to incorporate DatabaseCleaner and adds the appropriate code to `features/support/env.rb`.


10. To enable interactive debugging, add `require 'byebug'` to `spec/rails_helper.rb`. 


11. Prepare the test base, run the first time or when the schema changes

```text
	rails db:migrate
	rails db:test:prepare 
```


12. (Optional)We can automate Cucumber and RSpec tests with the guard, guard-rspec and guard-cucumber gems. Guard watches your files and automatically runs your specs when ever they are modified.

First, generate the guard file by running the following command at the command prompt:

```ruby
	bundle exec guard init rspec 
 ```

To add the required Cucumber configuration to the Guardfile and run guard, execute the following commands:

```ruby
	bundle exec guard init cucumber
	bundle exec guard # start guard
```


## Check RSpec configuration


We'll test the RSpec configuration by creating a Contact model using the Rails generator and then run the migration. The `rspec-rails` and `factory_bot_rails` gems will automatically create a number of 'skeleton' files `spec/models/contact_spec.rb` and `spec/factories/contacts.rb` respectively. The last migration command will create the test database.

 
```text
	bundle exec rails generator model Contact name:string address:string phone_number:string
	
	bundle exec rails db:migrate
	bundle exec rails db:migrate RAILS_ENV=test
```

Define a contact factory using Factory Bot, and write the spec to test it's attributes.

```ruby
	# spec/factories/contacts.rb
  FactoryBot.define do
    factory :contact do
      name "John Smith"
      address "1 the street, the town, the country"
      phone_number '1234567890'
    end
  end
  
  # spec/models/contact_spec.rb
  require 'rails_helper'
  
  RSpec.describe Contact, type: :model do
  
  	context 'validate model attributes' do
      it {is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_presence_of(:address)}
      it {is_expected.to validate_presence_of(:phone_number)}
      it {is_expected.to validate_length_of(:phone_number).is_at_least(10)}
  	end
  	
  	context 'validate factory bot implementation' do
	  	before {@contact = create(:contact)}
  		
  		it "is a valid user" do
				expect(@contact).to be_valid
			end
		end
  
  end
```

Add the necessary validations to the Contact model to pass

```ruby
	class Contact < ApplicationRecord
  	validates_presence_of :name, :address
  	validates :phone_number, presence: true, length: {minimum: 10}
  end
```


## Check Cucumber configuration

We'll simply check that the contact's address book page display's their contact details.

```gherkin
	# features/contact_page.feature
  Feature: Contact page
  
  Scenario: Viewing the contact's details
  Given there is a contact with name "John Smith" the address "Any street, any town" and phone number "1234567890"
	 When I am on the "contact" page of "John Smith"
	 Then I should see "John Smith"
	 And I should see "Any street, any town"
	 And I should see "1234567890"
```

From the cli run the following command:

```text
	bundle exec cucumber features/contact_page.feature
```

Cucumber will output a series of snippets which you can copy and paste in to your steps file and implement.

```ruby
	# features/step_definitions/contact_page_steps.rb
  Given(/^there is a contact with name "([^"]*)" the address "([^"]*)" and phone number "([^"]*)"$/) do |name, address, phone_number|
  	@contact = FactoryBot.create(:contact, name: name, address: address, phone_number: phone_number)
  end
  
  When(/^I am on the "([^"]*)" page of "([^"]*)"$/) do |page, name|
  	@contact = Contact.find_by_name(name)
  	visit "/contacts/#{@contact.id}"
  end
  
  Then(/^I should see "([^"]*)"$/) do |string|
  	expect(page).to have_text(string)
  end
```

Executing `bundle exec cucumber features/contact_page.feature` once more and the first feature passes. Following the next few steps, we can get all the features to pass. In between each step execute the cucumber feature.

1. implement the route

```ruby
	# config/routes.rb
	Rails.application.routes.draw do
  	resources :contacts, only: [:show]
  end
```

2. implement the controller and action

```ruby
	# app/controllers/contacts_controller.rb
	class ContactsController < ApplicationController
  
  	def show
  		@contact = Contact.find(params[:id])
  	end
  end
```

3. implement view

```erb
	# app/views/contacts/show.html.erb
	<p><%= @contact.name %></p>
	<p><%= @contact.address %></p>
	<p><%= @contact.phone_number %></p>
```



## References
[Setting up Rails for BDD](https://semaphoreci.com/community/tutorials/setting-up-the-bdd-stack-on-a-new-rails-4-application)
[Capybara](https://github.com/teamcapybara/capybara)
[Capybara-Webkit](https://github.com/thoughtbot/capybara-webkit)  
[Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers)      
[Factory Bot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)  
[SompleCov](https://github.com/colszowka/simplecov)  
[DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner)  
[Rails helper example](https://gist.github.com/justin808/3dd1211c299f68042551)  
[Guard](https://github.com/guard/guard)
[Guard RSpec](https://github.com/guard/guard-rspec)
[Guard Cucumber](https://github.com/guard/guard-cucumber)