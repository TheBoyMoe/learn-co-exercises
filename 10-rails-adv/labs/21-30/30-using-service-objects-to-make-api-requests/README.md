# Service Objects

## Objectives

1. Learn why service objects are important
2. Refactor API calls from controllers to a service object

## Lesson

We'll be continuing with the Foursquare Coffee Shop app. You can build on the one you've been working with, or use the included code.

## Service Objects

Congrats on getting your Foursquare Venue Tips to work! While working on these features, you might have started to wonder if everything we're doing: talking to the Foursquare API, parsing Foursquare data, really belongs in our controllers.

If we think back to *Single Responsibility Principle*, and the purpose of the components of MVC, we can come to the conclusion that we're forcing our controllers to know too much about Foursquare and the business logic of the data we get from the API when controllers are really supposed to be shuffling data back and forth between models and views.

We want to move our business logic out of our controllers, but how? We aren't going to use an `ActiveRecord` Model, because we're not dealing with our own database.

We are, however, dealing with data from *someone's* database, and the business logic of consuming and transforming that data, so we need something else.

**Service Objects**.

A service object is an object that we can use to encapsulate the inner workings of some business or *domain* logic that isn't strictly the responsibility of a single `ActiveRecord` model.

If you can imagine a complex CRM system, the act of creating a new customer might involve also setting up a sales pipeline, creating tasks and calendar items for a salesperson, and other related stuff. That all doesn't belong in the `Customer` model, but it also certainly doesn't belong in the `CustomersController`, so we would encapsulate it into a service object.

Similarly, in our system, things like dealing with OAuth, or knowing how to query the Foursquare API don't belong in our controllers or models, so we need service objects.

According to a [post by Tom Pewiński in Ruby Weekly](https://netguru.co/blog/service-objects-in-rails-will-help):

> As I understand it, a Service Object implements the user’s interactions with the application. It contains business logic that coordinates other artefacts. You could say it is the core of the application.

We're going to use service objects to execute our interactions with the external Foursquare API.

## Refactoring Authentication

#### Extracting A Service Object

Currently, your `SessionsController` `create` action looks something like this:

```ruby
# sessions_controller.rb
  def create
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
```

Create the folder `app/services` and create a file `foursquare_service.rb` within that folder. Then define a `FoursquareService` class.

```ruby
# app/services/foursquare_service.rb

class FoursquareService
end
```

Now, let's move the API interaction from `SessionsController` into `FoursquareService`. Define a method called `#authenticate!`. Our arguments will be the client ID, client secret, and code that we need to authenticate with Foursquare:

```ruby
  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
    end
    body = JSON.parse(resp.body)
    body["access_token"]
  end
```

Looks very familiar, right? We've just moved the code from the controller to the service object, almost as-is. The only real difference is we pass in the parameters from the controller.

**Advanced:** This is an example of an ["Extract Method"](http://refactoring.com/catalog/extractMethod.html) refactoring. Anywhere you can simply cut code from one place into a new method is a place where you might be violating Single Responsibility Principle.

#### Back to the Controller

Now that we've started to set up our `FoursquareService` object, what do we need to do in our `SessionsController`? Instantiate a new `FoursquareService` object and call our `#authenticate!` method!

```ruby
# sessions_controller.rb
def create
  foursquare = FoursquareService.new
  session[:token] = foursquare.authenticate!(ENV['FOURSQUARE_CLIENT_ID'], ENV['FOURSQUARE_SECRET'], params[:code])
  redirect_to root_path
end
```

Now our controller is much cleaner. All it has to know is that there's a `FoursquareService` that can provide an OAuth token.

We pass in the client ID and secret via our `.env` environment variables because just as it's not the responsibility of the controller to know the internals of the Foursquare API, it's not the responsibility of the Foursquare service to know where to go to get system data.

If we run our Rails server, everything should still work as expected. To verify, trying accessing `/search` in a private tab that won't have your session already stored.

### Refactoring Friends

We've cleaned up the OAuth flow for the `SessionsController` using a service object. Now let's look at doing the same for our `friends` action.

Extract the Foursquare API call from the `friends` action in `SearchesController` and put it into a new `friends` method in the Foursquare service object.

```ruby
# services/foursquare_service.rb
# ...
  def friends(token)
    resp = Faraday.get("https://api.foursquare.com/v2/users/self/friends") do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end
```

Here we go as far as to return just the part of the JSON response that we need to build a friends list, rather than forcing the controller or view to know how to pull the right data. Since the method is named `friends`, it makes sense that it would just return a representation of the friends.

Then in our controller, we can update the `friends` action to use the service object:

```ruby
# searches_controller.rb
# ...
  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end
```

Now if we reload our `/friends` page, we should still see our friends!

## Summary

We've learned that service objects help us encapsulate business logic that doesn't belong in a controller or `ActiveRecord` model, allowing us to keep our controllers ["skinny"](http://robdvr.com/fat-models-skinny-controllers-skinny-models-skinny-controllers/) and observe the Single Responsibility Principle.

We've also extracted controller code into our service object and refactored our controllers to use our new service.

For extra practice, finish extracting the rest of the Foursquare API calls in our Coffee Shop application so that all of the Foursquare logic is in our `FoursquareService`.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/web-service-objects-readme' title='Service Objects'>Service Objects</a> on Learn.co and start learning to code for free.</p>
