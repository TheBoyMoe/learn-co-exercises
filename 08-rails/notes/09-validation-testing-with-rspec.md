# Testing in Rails


## Three Test Types

We'll be covering three types of tests:

- **Models** (RSpec)
- **Controllers** (RSpec)
- **Features** (RSpec/Capybara)

Features are the fanciest, so we'll leave them for last. They are preferred over
regular Rails "View" tests.


## RSpec setup

By default, Rails uses `Test::Unit` for testing, which keeps its tests in the `test/` folder.

If you're planning from the start to use RSpec instead, you can tell Rails to
skip `Test::Unit` by passing the `-T` flag to `rails new`, like so:

```
rails new cool_app -T
```

Then, you will add the gem to your Gemfile:

```ruby
gem 'rspec-rails'
```

And use the built-in generator to add a `spec` folder with the right boilerplate:

```
bundle install
bundle exec rails g rspec:install
```

This is the Rails equivalent of the usual `rspec --init`.


## Capybara setup

Add the gem to the `Gemfile`:

```
gem 'capybara'
```

Then set up Capybara-Rails integration in `spec/rails_helper.rb`:

```ruby
require 'capybara/rails'
```

Then set up Capybara-RSpec integration in `spec/spec_helper.rb`:

```ruby
require 'capybara/rspec'
```


## Model Tests

Models are not too difficult to test because they have very specific purposes
that can be easily separated from the rest of the application.

These go in `spec/models`, one file per model.

Model tests use the least amount of special features, since all you really need
is the model class itself. The most common usage for model tests is to make sure
you have set up your validations correctly, e.g


```ruby
# app/models/monster.rb

class Monster < ActiveRecord::Base
  validates :name, presence: true
  validates :size, inclusion: { in: ["tiny", "average", "like, REALLY big"] }
  validates :taxonomy, format: { with: /\A[A-Z](\.|[a-z]+) [a-z]{2,}\z/,
    message: "must include genus and species, like 'Homo sapiens'" }
end
```

## Testing for Validity

First, we'll make sure that it understands a valid Monster:

```ruby
# spec/models/monster_spec.rb

describe Monster do
  let(:attributes) do
    {
      name: "Dustwing",
      size: "tiny",
      taxonomy: "Abradacus nonexistus"
    }
  end

  it "is considered valid" do
    expect(Monster.new(attributes)).to be_valid
  end
end
```


### What is `let`?

`let` it is a [standard helper method](http://www.relishapp.com/rspec/rspec-core/docs/helper-methods/let-and-let)
that takes a symbol and a block. It runs the block **once per example** in which
it is called and saves the **return value in a local variable** named according to
the symbol. This means you get a fresh copy in every test case.

### Why is `let` better than `before :each`?

It's more fine-grained, which means you have better control over your data. It
can be used in combination with `before` statements to set up your test data
*just right* before the examples are run.

### Why did we use `let` to make an attribute hash?

We could have put the entire `Monster.new` call inside our `let` block, but
using an attribute hash instead has some advantages:

- If we want to tweak the data first, we can just pass `attributes.merge(name:
  "Other")` while preserving the rest of the attributes.
- We can also refer to `attributes` when making assertions about what the actual
  object should look like.

It's a good balance between saving keystrokes and maintaining the flexibility of
your test data.

### Where does `be_valid` come from?

`be_valid` is not a built in RSpec matcher. '#be_valid' is a "[predicate
matcher](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/predicate-matchers)".

In Ruby, it's conventional for methods that return `true` or `false` to be named
with a question mark at the end. These methods are called **predicate methods**,
because "predicate" is an English grammar term for the part of a sentence that
makes a statement about the subject.

Rails provides a `valid?` method that returns `true` or `false` depending on 
whether the model object in question passed its validations.

In RSpec, when you call a nonexistent matcher (such as `be_valid`), it strips
off the `be_` (`valid`), adds a question mark (`valid?`), and checks to see if
the object responds to a method by that name (`monster.valid?`).


## Testing for Validation Failure


```ruby
# spec/models/monster.rb

  let(:missing_name) { attributes.except(:name) }
  let(:invalid_size) { attributes.merge(size: "not that big") }
  let(:missing_species) { attributes.merge(taxonomy: "Abradacus") }

  it "is invalid without a name" do
    expect(Monster.new(missing_name)).not_to be_valid
  end

  it "is invalid with an unusual size" do
    expect(Monster.new(invalid_size)).not_to be_valid
  end

  it "is invalid with a missing species" do
    expect(Monster.new(missing_species)).not_to be_valid
  end
```

Note that each of these `let` blocks rely on the first one, `attributes`, which
contains all of our valid attributes. `missing_name` uses the Rails hash helper
`except` to exclude the `name` key while the other two use the standard Ruby
`merge` method to overwrite valid attributes with invalid ones.



## Controller Tests

The biggest risk in writing controller tests is redundancy: controllers exist
to connect views and models, so it's difficult to test them in isolation.


```ruby
# spec/controllers/monsters_controller_spec.rb

describe MonstersController, type: :controller do
  let(:attributes) do
    {
      name: "Dustwing",
      size: "tiny",
      taxonomy: "Abradacus nonexistus"
    }
  end

  it "renders the show template" do
    monster = Monster.create!(attributes)
    get :show, id: monster.id
    expect(response).to render_template(:show)
  end

  describe "creation" do
    before { post :create, monster: attributes }
    let(:monster) { Monster.find_by(name: "Dustwing") }

    it "creates a new monster" do
      expect(monster).to_not be_nil
    end

    it "redirects to the monster's show page" do
      expect(response).to redirect_to(monster_path(monster))
    end
  end
end
```

You can use the `get` and `post` methods (along with `patch` and `delete`) to
initiate test requests on the controller. A `response` object is available to
set expectations on, such as `render_template` or `redirect_to`.

The tests above are great, especially while we're still getting used to how
controllers are wired. However, almost these exact tests could be copied for
*any* controller set up according to Rails' RESTish conventions. There's nothing
inherently wrong with that, but the redundance, along with the need to test
views, inspired the creation of a new type of test supported by Capybara known
as a "Feature Test".


# Feature Tests

If you were going to write tests for a car's steering wheel, what would you
start with?

Here's one idea:

> When the steering wheel is rotated to the left, the tires rotate to the left.

This makes sense, but it's testing much more than the steering wheel. This test
relies on the view (steering wheel), the model (tires), *and* the controller
(steering column)!

This is called an **acceptance test** because it is phrased in terms of
features that provide value to the user. (It could also be called an
**integration test** because it tests more than one piece of the system at
once.)

Can we *isolate* the steering wheel while still testing its functionality?

Not really –– the whole point of the steering wheel is to control the tires. We
could talk about how it looks or what it's made of, but the functionality is
inherently tied to the underlying system, just like the views in a Rails app.
All of those forms and templates are meaningless without controllers and models
to populate them.

In the last section, we did our best to isolate the controller, and, as a result,
we wrote many of our tests in terms of the controller's internal parts (such as
redirects and request methods). We don't care what the HTML looks like, what
button the user pressed, or how the models are behaving.

This is called a **unit test**, because it tests a single unit of functionality.

For a car, it might look like this:

> When the steering column's flange rotates, the steering shaft transmits the
> rotation to the steering box.

It can be difficult to write isolated **unit tests**, and
it's not always clear whether they're useful. Compare the jargon-heavy, extremely
specific unit test, above, to this test covering the steering wheel
(view) *and* steering column (controller):

> When the steering wheel is rotated to the left, the steering column transmits
> the rotation to the steering box.

This is a **feature test**.

The **acceptance test** at the top of this section covers too much ground,
making it brittle and difficult to maintain.

The **unit test** in the middle of this section is so specific that it almost
feels like we just rewrote the controller code with different phrasing.

The **feature test**, on the other hand, is Just Right. It lets us think like a
user (in terms of the steering wheel, or view) while still making intelligent
assertions about how the underlying system should respond to input (in terms of
the steering column, or controller).

Now, on to the *how*.


## Capybara

When you see key words like `visit`, `fill_in`, and `page`, you know you're
looking at a [Capybara](https://github.com/jnicklas/capybara) test.

Feature tests are traditionally located in `spec/features`, but you can put them
anywhere if you pass the `:type => :feature` option to your `describe` call.

To test our monster manager with Capybara, we'll start by setting up a `GET`
request and then use Capybara's convenient helper functions to interact with the
page just like a user would:

```ruby
# spec/features/monster_creation.rb

describe "monster creation", type: :feature do
  before do
    visit new_monster_path
    fill_in "Name", with: "Dustwing"
    select "tiny", from: "monster_size"
    fill_in "Taxonomy", with: "Abradacus nonexistus"
    click_button "Create Monster"
  end
 end
```

When `click_button` is called, this will trigger the `POST` request to the
controller's `create` action, just as if a user had clicked it in their browser.

Now, we can write our original controller tests like usual:

```ruby
  let(:monster) { Monster.find_by(name: "Dustwing") }

  it "creates a monster" do
    expect(monster).to_not be_nil
  end

  it "redirects to the new monster's page" do
    expect(current_path).to eq(monster_path(monster))
  end
```

With capybara we can also have a very convenient way of making
assertions about the final `GET` request:

```ruby
  it "displays the monster's name" do
    within "h1" do
      expect(page).to have_content(monster.name)
    end
  end
```

`within` sets the context for our next expectation, restricting it to the first
`<h1>` tag encountered on the page. This way, our `expect` call will only pass
if the specified content (`"Dustwing"`) appears inside that first heading.

One interesting thing about this approach is that we're being much *less*
explicit about certain expectations. For example, we're testing the redirect not
with the initial `302` response but instead by examining the current path in
Capybara's virtual "browser session". This is much more powerful and intuitive,
and it doesn't sacrifice much in the way of expressivity.


### Summary

These can serve as fairly reliable guidelines:

- Models should always be thoroughly unit tested.
- Controllers should be as thin as possible to keep your feature tests simple.
- If you can't avoid making a controller complex, it deserves its own isolated
  test.
- Limit testing of views: you just need to make sure the information is in the right place. If your tests are too strict, it will be impossible to make even simple tweaks to your templates without
  breaking the build.

