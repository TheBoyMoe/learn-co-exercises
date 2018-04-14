# jQuery Tic-Tac-Toe with a Rails API — Part 1

This lab is the first half of a two-part challenge in which you're tasked with building a browser-based Tic-Tac-Toe game using jQuery and a Rails API.

Once you're done with both labs, you should have a finished product that behaves like [this video](http://flatiron-videos.s3.amazonaws.com/Learn%20Curriculum%20Helpers/ttt.mov) (right-click and `Save Link As...` to download).

## Objectives
- Explore the directory structure of a single-page application.
- Set up routes and actions to serve JSON via a Rails API.
- Use the ActiveModelSerializers (AMS) gem to serialize Ruby objects to and from JSON.
- Create a custom serializer that overrides the default provided by AMS and complies with the JSON:API specification.
- Learn about the `ActiveRecord::Base#serialize` method for serializing arrays, hashes, and other non-mappable objects.

## Directory structure of a single-page application
Since this may be the first single-page app (SPA) you've built, let's take a minute to check out the directory structure.

Our application has only a single view, `app/views/home/index.html`, in which we've sketched out the visual components of our tic-tac-toe game. We'll talk more about the individual elements in the next lesson when we start wiring up all of the functionality with jQuery. For now, just marvel at the simplicity of our lone view, controller (`app/controllers/home_controller.rb`), and route (`root 'home#index'`).

Even after we've finished building our fully-featured tic-tac-toe game, `home/index.html` will _still_ be the only page that gets loaded by the browser. Once loaded, users will be able to play tic-tac-toe games, save in-progress games, view a list of all saved games, and load any saved game state back onto the board to continue playing — all _without refreshing the page_. The magic of JavaScript!

Before we can dive into all that `function`-y goodness, we first need to set up the back end of our application.

## Setting up our Rails API

### What time is it? `Game` time!
Our tic-tac-toe domain model centers on a `Game` class. Every instance of `Game` will have a unique `id` as well as a `state` property, an array representing the current state of the board. If you plumb the depths of your memory, this may look a bit familiar from your first days learning Ruby:
```ruby
#  X | O | X
# -----------
#    | O | O
# -----------
#    |   | X

state = ["X", "O", "X", "", "O", "O", "", "", "X"]
```

There's nothing for us to add to the existing `Game` class... _yet_... but there's plenty of other work to do! If you hop into the test suite, you'll see that we have some routes and controller actions to set up.

### Routes and controllers and JSON, oh my!
Most of the work required to set up the `GamesController` will be a straightforward review of the preceding ActiveModelSerializers and `to_json` labs. You'll need to set up routes and actions for the following API endpoints:
1. Create — `POST` — `/games`
2. Show — `GET` — `/games/:id`
3. Update — `PATCH` — `/games/:id`
4. Index — `GET` — `/games`

***HINT***: As you're working through the `GamesController` tests, you might happen upon some `MissingTemplate` errors. Remember that we're building an *API*, so we definitely don't need to add any templates for our `GamesController` actions. If you're having some trouble figuring it out, take a look back at previous labs, and, as always, _remember, remember the point of the `render`!_

![V for Vendetta](https://user-images.githubusercontent.com/17556281/27201976-c7e3a00e-51ed-11e7-800b-e038f867ff01.gif)

### ActiveModelSerializers
To ensure that our Rails API plays nicely with the forthcoming JavaScript front-end, we're relying on our old friend ActiveModelSerializers to serialize `Game` objects into JSON and back.

***NOTE***: We're using AMS v0.10.6, which introduced a _ton_ of breaking changes over version 0.9.x — check out [the documentation](https://github.com/rails-api/active_model_serializers/tree/v0.10.6) if you run into any trouble.

Once your routes and `GamesController` actions are set up properly, you should be seeing RSpec errors like this:
```ruby
2) GamesController#show returns a JSON:API-compliant, serialized object representing the specified Game instance
  Failure/Error: expect(parsed_json).to eq(correctly_serialized_json)

    expected: {"data"=>{"id"=>"1", "type"=>"games", "attributes"=>{"state"=>["", "", "", "", "", "O", "", "", "X"]}}, "jsonapi"=>{"version"=>"1.0"}}

    got: {"id"=>1, "state"=>"[\"\", \"\", \"\", \"\", \"\", \"O\", \"\", \"\", \"X\"]", "created_at"=>"2017-06-29T14:27:26.521Z", "updated_at"=>"2017-06-29T14:27:26.521Z"}

    (compared using ==)

    Diff:
    @@ -1,3 +1,5 @@
    -"data" => {"id"=>"1", "type"=>"games", "attributes"=>{"state"=>["", "", "", "", "", "O", "", "", "X"]}},
    -"jsonapi" => {"version"=>"1.0"},
    +"created_at" => "2017-06-29T14:27:26.521Z",
    +"id" => 1,
    +"state" => "[\"\", \"\", \"\", \"\", \"\", \"O\", \"\", \"\", \"X\"]",
    +"updated_at" => "2017-06-29T14:27:26.521Z",

    # ./spec/controllers/games_controller_spec.rb:47:in `block (3 levels) in <top (required)>'
```

Your calls to `render json: <object>` (did you _remember_?) are being intercepted by ActiveModelSerializers, but the gem isn't formatting them correctly.

We're trying our best to be _Good Developers_™, which means we should adhere to [v1.0 of the JSON:API specification](http://jsonapi.org/format/1.0/) when serializing objects. Unfortunately, AMS v0.10.6 defaults to its own serialization strategy, so we need to do a bit of manual configuration.

#### AMS configuration
Create a new Ruby file in the `config/initializers/` directory. You can name the file whatever you want, but something like `active_model_serializers.rb` or `ams.rb` would make the most sense. Inside that file, paste the following code:
```ruby
# config/initializers/active_model_serializers.rb

ActiveModelSerializers.config.tap do |c|
  c.adapter = :json_api
  c.jsonapi_include_toplevel_object = true
  c.jsonapi_version = "1.0"
end
```

This tells AMS to use the `:json_api` serialization adapter, to include a top-level object, and to adhere to v1.0 of the JSON:API specification. For some reason, AMS's default `:json_api` configuration does not include a top-level object, despite the JSON:API specification's insistence on a top-level object called `"data"`.

***Top Tip***: If you want to learn more about the various configuration options for ActiveModelSerializers, head on over to [the documentation](https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/configuration_options.md)!

At this point, we're getting close to a fully functional, JSON:API-compliant serializer. However, there are two final pieces we have to set up.

#### `GameSerializer`
AMS defaults to serializing _every_ attribute on a model, but for this project we don't care when a `Game` instance was created or updated. To control which attributes get serialized, we're going to create a custom serializer that inherits from the base `ActiveModel::Serializer` class.

When we call on AMS to serialize an object (or collection of objects), AMS will first look in the `app/serializers/` directory (if one exists) to see if a user-defined serializer matches the object(s) to be serialized. Let's use the AMS generator that we learned about a few labs ago to create a new `GameSerializer`...
```bash
rails g serializer Game state
```
...which should result in the following code in `app/serializers/game_serializer.rb`:
```ruby
class GameSerializer < ActiveModel::Serializer
  attributes :id, :state
end
```

#### Serializing non-mappable objects
Now, the `created_at` and `updated_at` attributes are excluded from our JSON output, but we're still seeing errors concerning the `state` attribute. If you look closely, you'll notice that it's currently being serialized as a string, `"[\"X\", \"O\", \"X\", \"\", \"\", \"\", \"\", \"\", \"\"]"`, instead of as an array, `["X", "O", "X", "", "", "", "", "", ""]`.

This is actually an issue with Active Record. We're currently trying to store the `state` attribute, an array, in a `TEXT`-typed database column. In order to properly store arrays, hashes, and other non-mappable objects in a `TEXT` column, we need to call [the `.serialize` class method provided by `ActiveRecord::Base`](http://api.rubyonrails.org/classes/ActiveRecord/Base.html):
```ruby
class Game < ActiveRecord::Base
  serialize :state, Array
end
```

And, with that, you've set up a JSON:API-compliant serialization scheme. Better still, all the tests should be passing!

Congrats! Now get ready for the sequel...

<p class='util--hide'>View <a href='https://learn.co/lessons/js-tictactoe-rails-api-backend'>jQuery Tic-Tac-Toe with a Rails API — Part 1</a> on Learn.co and start learning to code for free.</p>
