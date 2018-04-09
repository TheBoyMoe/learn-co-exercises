# Posting to APIs

## Objectives

  1. Understand what POST params are
  2. Send POST requests with params via Postman and Faraday
  3. Understand the difference between POST params and JSON in the body

## Lesson

We're going to keep working with our Foursquare application and allow users to add tips to venues. The solution from the OAuth reading is included.

**Note:** Don't forget to set up your `.env` file (or copy it from the previous lesson)!

## Working With A POST API Endpoint

If we look at the [Add Tip documentation](https://developer.foursquare.com/docs/tips/add), we'll see that we need to make this request via POST. Up until now we've been making GET requests, because we're just asking for data. But once we start changing data on the server, we're in POST territory.

According to the docs, we'll need to POST to `https://api.foursquare.com/v2/tips/add` with a `venueId`, some `text`, and, since it requires an acting user, our `oauth_token`. If you need a refresher on how to do OAuth with Foursquare, click the [learn more link](https://developer.foursquare.com/overview/auth) next to where it says **Requires Acting User**.

### POSTing with Postman

Let's try this out in Postman first.

We'll need our oauth token to do this. Fortunately we already have this in our app, so to get it into Postman, we're going to temporarily display it on the page so we can copy and paste it:

```erb
# searches\search.html.erb
<%= session[:token] %>
# ...
```

Output `session[:token]` to the search page, run your Rails server, and browse to `/search`. It should look something like: `B2JPA4ZSC5244X1Q1C2OPWYGTZ2LSALF1Z`

**Note:** We would *never* actually output the token in a real-world scenario, we just need it to play around in Postman. We'll delete that line shortly.

Next we need a venue ID. If you go into Postman, you should see a list of previous queries on the left side under **History**. Choose one where you successfully queried the Venue Search API and run it. Grab the `id` value from the first venue result.

Armed with those, let's start a new POST request (make sure to change the selection from GET to POST to the left of the URL field).

So, we're going to POST to `https://api.foursquare.com/v2/tips/add`, then we need to set our params per the docs:

```
venueId      YOUR_VENUE_ID
text         Love this place!
oauth_token  YOUR_TOKEN
v            20160201
```

Don't forget that pesky `v` parameter for Foursquare versioning!

If we've done it right, when we hit "Send", we should get a response that looks something like this:

```javascript
"response": {
    "tip": {
      "id": "56c223e1498e82b67c98f548",
      "createdAt": 1455563745,
      "text": "Love this place!",
      "type": "user",
      "canonicalUrl": "https://foursquare.com/item/56c223e1498e82b67c98f548",
      "likes": {
        "count": 0,
        "groups": []
      },
// ...
```

Just like that, we've created a tip!

### POSTing In Rails With Faraday

Okay, we've seen it work in Postman, now let's get it into our Rails application. We want to create a way to POST a tip on a venue after we've searched for it.

Let's start with a form in our search results:

```erb
# search.html.erb
<h1>Search for Coffee Shops Near Me</h1>
<%= form_tag '/search' do %>
  <%= label_tag :zipcode %>
  <%= text_field_tag :zipcode %>
  <%= submit_tag "Search!" %>
<% end %>
<div>
  <% if @error %>
    <p><%= @error %></p>
  <% elsif @venues %>
    <ul>
    <% @venues.each do |venue| %>
      <li>
        <%= venue["name"] %><br>
        <%= venue["location"]["address"] %><br>
        Checkins: <%= venue["stats"]["checkinsCount"] %><br>
        <%= form_tag '/tips' do %>
          <%= hidden_field_tag :venue_id, venue["id"] %>
          Add tip: <%= text_field_tag :tip %><%= submit_tag "Add Tip" %>
        <% end %>
      </li>
    <% end %>
    </ul>
  <% end %>
</div>
```

We need to keep track of the venue ID for when we create the tip, so we'll hold onto it in a `hidden_field_tag` on the tip form.

**Note:** Now is a good time to delete the line that outputs `session[:token]`.

Now we need to set up a route for our form to POST to, and a route to see our tips after we've added them:

```ruby
# routes.rb
# ...
resources :tips, only: [:index, :create]
```

Let's get into the `TipsController` and set up the `create` action:

```ruby
# tips_controller.rb
#...
  def create
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20160201'
      req.params['venueId'] = params[:venue_id]
      req.params['text'] = params[:tip]
    end

    redirect_to tips_path
  end
```

This looks similar to other calls we've made, except we're doing `Faraday.post` instead of `Faraday.get`. We're passing in our values as `params` just like with a GET request (more on this in a minute), and we get a response.

In this case, we want to show that it worked, so we're going to redirect to `tips_path` and show the user their tips.

Read the [List Detail](https://developer.foursquare.com/docs/lists/lists) document and see if you can set up the `index` action of our `TipsController`.

```ruby
# tips_controller.rb
def index
  resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
    req.params['oauth_token'] = session[:token]
    req.params['v'] = '20160201'
  end
  @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
end
# ...
```

Looks very similar to our `friends` action.

It seems a little crazy that we have to dig so deep (`["response"]["list"]["listItems"]["items"]`) just to get to the actual tips list, but that is how deep they are nested in the response. You'll need to pay careful attention to the documentation and the response to make sure you're grabbing what you need from the response body.

And let's round it out by displaying the tips in our `index.html.erb` template:

```erb
# tips/index.html.erb
<h1>My Tips</h1>
<ul>
<% @results.each do |item| %>
  <li><strong>><%= item["venue"]["name"] %></strong><br>
    <%= item["tip"]["text"] %></li>
<% end %>
</ul>
```

Now we can load our Rails server, go to `/search`, search for coffee shops, add a tip to one we like, and see our tips!

### POST Params vs POST Body

The Foursquare API endpoints we've been using all have used *parameters* to pass data. For a GET request, those are querystring parameters. For a POST, they are `www-form-urlencoded` parameters - that is, they act as if we had created a `form` and clicked `submit`.

Other API providers, like Github, may require that POST data instead be JSON-formatted text in the request `body`. A request has a `body` just like a response does.

Fortunately, Faraday makes it easy to POST with JSON in the body of the request. Instead of doing:

```ruby
Faraday.post("https://url/to/api") do |req|
  req.params['my_param'] = my_value
end
```

You can do this:

```ruby
Faraday.post("https://url/to/api") do |req|
  req.body = "{ "my_param": my_value }"
end
```

All you have to do is assign the request `body` to a properly formatted JSON string!

In Postman, there's a section under the URL entry that has a place where you can enter a **Body** as well, so you can test APIs that take params or JSON in the body equally well.

Pay close attention to the documentation of the API provider to make sure you're setting your request data in the right place!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-posting-requests' title='Posting to APIs'>Posting to APIs</a> on Learn.co and start learning to code for free.</p>
