## MVC and Capybara Tests

There are 3 levels of tests that correspond to the different levels in our app's architecture.

![Web Application Stack and Tests](https://dl.dropboxusercontent.com/s/k2ypcn86btb6ajo/2015-09-29%20at%204.14%20PM.png)

### Testing Our Application Stack

**Models:** Our model interacts with our database. It maps a table rows to instances of ruby classes and vice-versa - ORM, provides an object-orientated abstraction. We use *Unit Tests* to test our models.

**Controllers:** Provide the application logic, decide what data should be shown in response to a user request - facilitate communication between the view and model layers. Controllers are represented as ruby classes. Controller tests ensure that the http request returns the expected http response. *Controller tests* do not test that forms or html.

**Views:** Present information to the user, can be 'puts' statements or erb templates which are rendered as html.

**User/client:** Top of the stack is our user, the client or interface they use could be a cli, browser or native app.

**Integration/End-to-End Tests** Describe how the user will interact with our app - used to test our apps functionality. They are the highest level of testing, testing all our mvc components working together,e.g. testing that user input entered in a form is saved to the database, and the appropriate response returned.


### Using Capybara

Capybara is a ruby gem used for integration testing in Sinatra and Rails apps. First step is to configure RSpec to use the Capybara methods.

```ruby
  # .rspec file
  # Load RSpec and Capybara
  require 'rspec'
  require 'capybara/rspec'
  require 'capybara/dsl'

  # Configure RSpec
  RSpec.configure do |config|
    # Mixin the Capybara functionality into Rspec
    config.include Capybara::DSL
    config.order = 'default'
  end

  # Define the application we're testing
  def app
    # Load the application defined in config.ru
    Rack::Builder.parse_file('config.ru').first
  end

  # Configure Capybara to test against the application above.
  Capybara.app = app
```
