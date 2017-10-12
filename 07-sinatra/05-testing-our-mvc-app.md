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
  # spec/spec_helper.rb file
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

Capybara provides a number of new methods, including:

visit and page - which allow us to examine the current state of the page,
click_button, click_link and fill_in -allow us to mimic user actions,

and matchers, such as:
'have_text', 'have_selector', 'have_field' - allow us to check that the page contains certain html elements or text.

**visit:** navigates the test's browser to a specific URL. It is equivalent to a user typing a URL into their browser's address bar. The method accepts a string argument, the url that you want to test, e.g. visit '/', and capybara will load that page, the root, within the test.

**page:** gives you a Capybara::Session object that represents the browser page the user would actually be looking at or whichever route was last passed to visit. The object responds to methods that represent actions that a user could take on a page, e.g. 'click_link', 'click_button', 'fill_in' and 'body'. The 'page.body' method will return the current page's html as a string.

```ruby
  it 'welcomes the user' do
    visit '/'
    expect(page.body).to include("Welcome!")
  end

  it 'has a greeting form with a user_name field' do
    visit '/'

    expect(page).to have_selector("form")
    expect(page).to have_field(:user_name)
  end

  it 'greets the user personally based on their user_name in the form' do
    visit '/'

    fill_in(:user_name, :with => "Tom")
    click_button "Submit"

    expect(page).to have_text("Hi Tom, nice to meet you!")
  end
```

In the preceding tests, we tell Capybara to visit the page at '/'. Once that is done, we set some expectations against the page object that represent the user looking at the page in their browser. We can simply assert that the page includes the 'Welcome!' text, has an HTML form tag, and a form field with either an 'id' or 'name' attribute with a value of 'user_name' The third test tries to mimic what a user should see when they visit the page, and fill in the input field with their name, 'Tom', and click the 'Submit' button.

When Capybara submits a form, the page object is appropriately updated. page no longer contains the original greeting form, but, rather, after click_button is called, page now contains the response to the greeting form. We can expect the page to have the text 'Hi Tom, nice to meet you!'.



### Resources

1. [Capybara Methods](https://github.com/teamcapybara/capybara#the-dsl)
